# Tmux Custom Keybindings Reference Guide (Updated with Plugins)

This guide documents the active shortcuts and features configured in this tmux configuration 

the **Prefix** key for this tmux set up is: **`Ctrl + Space`** (referred to as `Prefix` below).

---

## 1. Global Navigation Shortcuts (No Prefix Required)

These shortcuts work instantly without hitting your prefix key first.

| Key combination | tmux Action | Vim/Neovim Analogy |
| :--- | :--- | :--- |
| **`Alt + h`** | Move focus to the **Left** pane | `Ctrl + w` then `h` (Left window) |
| **`Alt + j`** | Move focus to the **Down** pane | `Ctrl + w` then `j` (Down window) |
| **`Alt + k`** | Move focus to the **Up** pane | `Ctrl + w` then `k` (Up window) |
| **`Alt + l`** | Move focus to the **Right** pane | `Ctrl + w` then `l` (Right window) |
| **`Shift + Alt + H`** | Cycle to the **Previous** window (tab) | `:bprev` or cycling left tabs |
| **`Shift + Alt + L`** | Cycle to the **Next** window (tab) | `:bnext` or cycling right tabs |

---

## 2. Standard Session & Layout Shortcuts (Prefix Required)

Tap **`Ctrl + Space`**, release them, and then press the target key.

| Key Sequence | tmux Action | Vim/Neovim Analogy |
| :--- | :--- | :--- |
| **`Prefix` then `v`** | Split the current pane **Vertically** (side-by-side) | `:vsplit` |
| **`Prefix` then `h`** | Split the current pane **Horizontally** (top-and-bottom) | `:split` |
| **`Prefix` then `H`** | Resize current pane **Left** (can hold/repeat key) | Ctrl-W `<` (decrease width) |
| **`Prefix` then `J`** | Resize current pane **Down** (can hold/repeat key) | Ctrl-W `+` (increase height) |
| **`Prefix` then `K`** | Resize current pane **Up** (can hold/repeat key) | Ctrl-W `-` (decrease height) |
| **`Prefix` then `L`** | Resize current pane **Right** (can hold/repeat key) | Ctrl-W `>` (increase width) |
| **`Prefix` then `q`** | **Kill** the current pane instantly (no confirmation prompt) | `:q` or `:bd!` |
| **`Prefix` then `r`** | **Reload** your `.tmux.conf` configuration immediately | Re-sourcing `init.vim` / `init.lua` |

---

## 4. Advanced Plugin Controls (Prefix Required)

These commands control the new plugin layers activated using **`TPM`**.

### Session Saving & Restoring (`tmux-resurrect`)
>[!NOTE]
>These shortcuts let you save your terminal workspace layout (splits, paths, running shells)
>and recover them later (even after a full computer restart

* **`Prefix` then `Ctrl + s`** — **Save** the current session state.
* **`Prefix` then `Ctrl + r`** — **Restore** the last saved session state.
* **Automatic Backup (`tmux-continuum`):** sessions are now silently saved in the background every **15 minutes**. When you restart your computer and open tmux, it will auto-restore your last state automatically.

---

## 5. Copy Mode Shortcuts (Enter Copy Mode First)

To enter Copy Mode, press **`Prefix` then `[`**.

| Key in Copy Mode | tmux Action | Vim/Neovim Analogy |
| :--- | :--- | :--- |
| **`v`** | Begin character-based visual selection | `v` (Visual select) |
| **`y`** | Yank selection to Wayland system clipboard and exit Copy Mode | `y` (Yank to register `+`) |
| **`Mouse Drag`** | Drag to select text; releasing it copies to Wayland system clipboard and exits Copy Mode | GUI selection behavior |
| **`q`** | Exit Copy Mode without copying | `<Esc>` to normal mode |

---

## 6. Installation & Scratch Setup (Debian, Arch, Fedora)

Use these commands and steps to replicate this exact terminal configuration on other machines.

### Step 1: Install Packages & Dependencies

Install `tmux`, `git` (for managing plugins), and clipboard interface utilities (`wl-clipboard` for Wayland sessions and `xclip` for X11 sessions).

* **Debian & Ubuntu based:**
  ```bash
  sudo apt update && sudo apt install -y tmux git wl-clipboard xclip
  ```
  * Installs the core packages and sets up display clipboard links.

* **Arch Linux based:**
  ```bash
  sudo pacman -Syu --needed tmux git wl-clipboard xclip
  ```
  *  Updates repository databases and installs necessary utilities.

* **Fedora based:**
  ```bash
  sudo dnf install -y tmux git wl-clipboard xclip
  ```
  *  Installs tmux, git, and clipboard links via DNF.

---

### Step 2: Create the Config File
Create the tmux user configuration file in your home directory if you don't have one yet:
```bash
touch ~/.tmux.conf
```

>[!NOTE]
>copy the custom configuration code block from this repo if you want 
>into the newly created tmux.conf file

---

### Step 3: Install the Tmux Plugin Manager (TPM)
Clone the plugin manager repository from GitHub:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
* *Purpose:* Copies the TPM framework to enable advanced plugins.
* *Use Case:* Installing the manager that coordinates session-saving and vim navigation.

---

### Step 4: Run and Initialize
1. Launch tmux:
   ```bash
   tmux
   ```

2. Press the key sequence: **`Ctrl + Space`**, then **`Shift + i`** (Capital `I`).
3. Press **`Enter`** to exit the installer prompt once it states "Done".

