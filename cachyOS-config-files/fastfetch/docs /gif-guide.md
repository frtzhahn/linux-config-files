# Fastfetch & Kitty Terminal: Animated GIF Ingestion & Display Guide

## 1. Overview and Problem Definition

Displaying animated graphics alongside system metrics in Fastfetch via the Kitty Graphics Protocol (`\x1b_G`) frequently encounters visual defects—specifically **frame stacking**, **ghosting**, and **motion trace accumulation**. 

These visual artifacts stem from the interaction of three distinct software layers:
1. **Delta-Frame Optimization:** GIF89a encoders crop non-changing regions to bounding boxes (`+X+Y`), relying on previous frames to provide static backgrounds.
2. **Missing or Incompatible Disposal Metadata:** Frames configured with `Disposal: None` (Method 1) instruct decoders not to clear the graphic buffer before drawing subsequent frames.
3. **Fastfetch Zero-Delay Override (`im7.c`):** Fastfetch includes an internal steering mechanism that forcibly converts `Disposal: Background` (Method 2) to `Disposal: None` (Method 1) whenever a frame declares a delay of `0` centiseconds (`image->delay == 0`). In transparent animations, this causes ImageMagick's `CoalesceImages` to stack all successive frames into a single accumulated composite.

---

## 2. System Architecture: Hardware vs. Software Logic

To maintain diagnostic transparency, rendering operations must be divided between the software stack and the hardware execution pipeline:

* **Software Logic (Application & Terminal Compositor Layer):**
  * **Fastfetch CLI:** Reads source assets via `libMagickCore` (ImageMagick 7), normalizes frame properties, scales pixel buffers to requested terminal cell metrics, and serializes raw 32-bit RGBA payloads into Kitty escape codes (`\x1b_Ga=T...` for keyframes and `\x1b_Ga=f...` for animation frames).
  * **Kitty Terminal Engine:** Parses the incoming stream over the Unix pseudo-terminal (PTY), uploads raw pixel buffers into GPU texture memory (VRAM), registers animation timing gaps (`z=<ms>`), and advances frames autonomously using its internal render loop.
  * **Wayland Compositor (SwayFX / wlroots):** Combines the surface buffer exported by Kitty with other desktop windows and passes the completed frame to the Linux DRM/KMS subsystem.
* **Hardware Logic (Display Controller Layer):**
  * **GPU Hardware Rasterizer (Intel HD Graphics 520):** Scans out composited video memory buffers to the display panel via eDP.
  * **Embedded Controller (EC):** Governs thermal thresholds, fan PWM curves, and low-level power states. The physical silicon and EC maintain zero awareness of GIF metadata, escape sequences, or terminal cell geometry.

---

## 3. The Universal Preprocessing Pipeline

Before configuring Fastfetch, source GIF assets must be normalized using ImageMagick (`magick`). Choose **Mode A** or **Mode B** depending on terminal presentation requirements.

### Mode A: True Transparency (For Transparent, Blurred, or Dynamic Terminals)

Use this method when running terminal background opacity, Wayland compositor blur (e.g., SwayFX), or desktop wallpapers where transparency pass-through is required.

```bash
magick /path/to/input.gif -set delay 8 -coalesce -dispose Background ~/.config/fastfetch/icons/output.gif
```

* **Command Purpose:** Enforces an explicit 80ms frame delay (`-set delay 8`), reconstructs delta bounding boxes to full canvas dimensions (`-coalesce`), and sets the Graphic Control Extension disposal flag to Method 2 (`-dispose Background`) while preserving the 1-bit palette alpha channel.
* **Use Case:** Preventing frame accumulation and bypassing Fastfetch's internal `delay == 0` override while maintaining clean alpha transparency.
* **Distribution Availability:** Package `imagemagick` on Arch Linux / CachyOS (`pacman -S imagemagick`), Debian / Ubuntu (`apt install imagemagick`), and Fedora (`dnf install ImageMagick`).

### Mode B: Solid Background Flattening (For Fixed Color Terminals)

Use this method when operating against a fixed terminal background color (e.g., Catppuccin Mocha `#1e1e2e`) to eliminate all semi-transparent fringe artifacts and palette anti-aliasing outlines.

```bash
magick /path/to/input.gif -set delay 8 -coalesce -background "#1e1e2e" -alpha remove -alpha off ~/.config/fastfetch/icons/output.gif
```

* **Command Purpose:** Reconstructs the canvas, blends transparent edge pixels against a target matte hex color (`-background` with `-alpha remove`), and strips the alpha channel completely (`-alpha off`).
* **Use Case:** Achieving perfectly crisp, opaque graphics on solid-color terminal themes with zero risk of alpha ghosting.
* **Distribution Availability:** Package `imagemagick` across standard Linux distributions.

---

## 4. Fastfetch Configuration Specification

In `~/.config/fastfetch/config.jsonc`, configure the `"logo"` block:

```jsonc
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "source": "~/.config/fastfetch/icons/output.gif",
    "type": "kitty",
    "animationFrame": 0,
    "position": "left",
    "width": 32,
    "height": 16,
    "padding": {
      "top": 1,
      "right": 4,
      "left": 1
    }
  },
  "modules": [
    // ...
  ]
}
```

### Key Configuration Parameters

| Parameter | Type | Required Value | Function |
| :--- | :--- | :--- | :--- |
| `"type"` | String | `"kitty"` | Emits native Kitty Graphics Protocol escape codes (`\x1b_G`). |
| `"animationFrame"` | Integer | `0` | **Critical:** Default is `1` (freezes on Frame 1). Setting `0` commands Fastfetch to transmit the full animation frame sequence. |
| `"width"` | Integer | Cell Count (e.g., `32`) | Width of the rendered image expressed in terminal character cells. |
| `"height"` | Integer | Cell Count (e.g., `16`) | Height of the rendered image expressed in terminal character cells. |
| `"position"` | String | `"left"` | Places the image adjacent to the metric module cards. |

---

## 5. Asset Parameter Tuning Matrix

While the ImageMagick pipeline structure is standardized, parameters must be tuned based on the source image geometry and target framerate:

### Frame Timing (`-set delay <N>`)

GIF delays are encoded in **centiseconds** (`1 cs = 10 ms = 1/100 s`):

| Centiseconds (`<N>`) | Milliseconds (`ms`) | Effective Framerate | Recommended Use |
| :--- | :--- | :--- | :--- |
| `10` | 100 ms | 10.0 FPS | Standard cartoon and anime animation loops. |
| `8` | 80 ms | 12.5 FPS | Optimal balance of smoothness and low GPU memory overhead. |
| `5` | 50 ms | 20.0 FPS | High-speed motion graphics. |
| `4` | 40 ms | 25.0 FPS | Video clips converted to GIF. |
| **`0`** | **0 ms** | **Invalid** | **Forbidden:** Triggers Fastfetch's internal `NoneDispose` mutation and stacks frames. |

### Terminal Character Cell Aspect Ratio

Terminal font cells are non-square rectangles, typically adhering to an approximate **1:2 width-to-height ratio** (e.g., 10x20 pixels per character cell). Image dimensions must compensate to prevent horizontal stretching:

* **Square Image (1:1 Ratio):** Set `width: 32`, `height: 16`.
* **Wide Banner (2:1 Ratio):** Set `width: 40`, `height: 10`.
* **Tall Banner (1:2 Ratio):** Set `width: 20`, `height: 20`.

---

## 6. Testing, Verification, and Rollback Procedures

### Isolated Protocol Test
To verify that Kitty can decode and loop the preprocessed asset independently of Fastfetch:

```bash
kitty +kitten icat --transfer-mode stream --loop -1 ~/.config/fastfetch/icons/output.gif
```
* **Command Purpose:** Streams raw Kitty Graphics Protocol escape sequences to stdout with infinite loop configuration (`--loop -1`).
* **Use Case:** Validating asset transparency, frame delays, and disposal behavior in isolation from CLI aggregator logic.
* **Distribution Availability:** Bundled with `kitty` (`pacman -S kitty`).

### Live Fastfetch Execution
Execute Fastfetch to confirm that text modules and animation frames align cleanly without stacking or flickering:

```bash
fastfetch -c ~/.config/fastfetch/config.jsonc
```
* **Command Purpose:** Executes Fastfetch against the specified configuration file.
* **Use Case:** Validating layout positioning, cell padding, and live graphics rendering.
* **Distribution Availability:** Available via system package repositories (`pacman -S fastfetch`).

### Rollback Procedure
If asset restoration is required:

```bash
cp -f ~/.config/fastfetch/icons/mocha_original.gif ~/.config/fastfetch/icons/mocha.gif
```
* **Command Purpose:** Overwrites the modified file with the untouched original backup copy.
* **Use Case:** Restoring the repository or system environment to its baseline state.
* **Distribution Availability:** GNU Coreutils standard (`cp`).

---

## 7. Technical Standards and Historical Quirks

* **GIF89a Disposal Methods:**
  * `0` (*Not Specified*): Decoder behavior is implementation-defined.
  * `1` (*Do Not Dispose*): Leaves existing graphic data in the display buffer; subsequent frames draw on top (used for delta-compression overlays).
  * `2` (*Restore to Background*): The frame canvas area is cleared to transparent/background color before drawing the next frame.
  * `3` (*Restore to Previous*): Reverts the frame area to the state prior to rendering the current frame.
* **Centisecond Clock Heritage:** The centisecond (1/100 s) timing format was established by CompuServe in 1989 because IBM PC compatibles operating under MS-DOS relied on the Intel 8253 Programmable Interval Timer (PIT) chip, which pulsed at ~18.2 Hz. A 10ms resolution was the highest timing precision that 80286/80386 microprocessors could reliably process without exhausting system interrupt vectors.
