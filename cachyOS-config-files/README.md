# CachyOS configs
this directory contains my primary configuration files for CachyOS, built around the **Sway Window Manager (Wayland)** and highly customized for performance and aesthetic visuals


| Folder / File | Description |
| :--- | :--- |
| `sway/` | core WM config including `lock.sh` and `idle.sh` for security reasons |
| `nvim/` | modular nvim setup using Lazy.nvim (see `lua/mocha/`) |
| `kitty-terminal` | terminal emulator configuration |
| `fastfetch` | customized themes for fastfetch configuration for system info display |
| `zshrc` | terminal configs with custom theme switching using keybinds |
| `cava/` | audio visualizer with custom GLSL shaders |
| `my-custom-discord-rpc/` | custom DRPC scripts for diverse apps |
| `scripts/` | collection of utility scripts (Battery, Pomodoro, Skids) |
| `yazi/` | configuration for the yazi terminal file manager |
| `ranger/` | configuration for the ranger file manager |
| `focus/` | script for enabling "Focus Mode" like pomodoro |

---

## Installation & Setup

> [!WARNING]
> these are my personal config files always back up your existing configurations before applying any of these

### Manual Symlinking
The recommended way to use these is to symlink them to your `~/.config` directory

```bash
# Example for Sway
ln -s ~/path/to/repo/cachyOS-config-files/sway ~/.config/sway

# Example for Neovim
ln -s ~/path/to/repo/cachyOS-config-files/nvim ~/.config/nvim
```

### Custom Scripts
make sure to add the `scripts` directories to your PATH so you can use them globally
```bash
export PATH=$PATH:~/path/to/repo/cachyOS-config-files/scripts/useful-scripts
```

---

## Core Dependencies
to get the full experience you will need the following installed:
- **WM:** `sway`, `swaybg`, `swaylock`, `swayidle`
- **Terminal:** `kitty`
- **Shell:** `zsh`, `oh-my-zsh`
- **Utilities:** `cava`, `yazi`, `ranger`, `neofetch`, `grim` (for screenshots)
- **Discord RPC:** `cord.nvim` (for Neovim)


