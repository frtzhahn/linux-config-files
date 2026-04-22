# Ubuntu configs 
this directory contains my stable X11-based configuration files primarily used as a backup or for systems that require X11 instead of wayland


| Folder / File | Description |
| :--- | :--- |
| `picom.conf` | compositor configuration for transparency and blur effects |
| `kitty.conf` | terminal emulator configuration |
| `old_nvim/` | legacy nvim config including `packer_compiled.lua`. |
| `neofetch` | custom neofetch configuration for system info display |
| `init.vim` | vim/nvim initialization script |
| `config` | customized i3 config file |

---

## Installation & Setup

> [!WARNING]
> These configurations are intended for X11 environments. Ensure you have a compatible window manager (like i3 or bspwm) before using `picom.conf`.

### Manual Symlinking
To apply these configs to your system:

```bash
# Example for Kitty
ln -s ~/path/to/repo/ubuntu-config-files/kitty.conf ~/.config/kitty/kitty.conf

# Example for Neofetch
ln -s ~/path/to/repo/ubuntu-config-files/neofetch ~/.config/neofetch/config.conf
```

### Neovim legacy config (not recommended to use)
The `old_nvim` folder contains a Packer-based setup. To use it:
```bash
ln -s ~/path/to/repo/ubuntu-config-files/old_nvim ~/.config/nvim
```

---

## Core Dependencies
To get the full experience, you will need the following installed:
- **Compositor:** `picom` (X11)
- **Terminal:** `kitty`
- **Shell:** `zsh`
- **Utilities:** `neofetch`
- **Editor:** `neovim` (for both legacy and `init.vim`)

---

