<div align="center">

```text
 ________  ________  ________   ________ ___  ________     
|\   ____\|\   __  \|\   ___  \|\  _____\\  \|\   ____\    
\ \  \___|\ \  \|\  \ \  \\ \  \ \  \__/\ \  \ \  \___|    
 \ \  \    \ \  \\\  \ \  \\ \  \ \   __\\ \  \ \  \  ___  
  \ \  \____\ \  \\\  \ \  \\ \  \ \  \_| \ \  \ \  \|\  \ 
   \ \_______\ \_______\ \__\\ \__\ \__\   \ \__\ \_______\
    \|_______|\|_______|\|__| \|__|\|__|    \|__|\|_______|
                                                           
                                                           
                                                           
     ________ ___  ___       _______   ________            
    |\  _____\\  \|\  \     |\  ___ \ |\   ____\           
    \ \  \__/\ \  \ \  \    \ \   __/|\ \  \___|_          
     \ \   __\\ \  \ \  \    \ \  \_|/_\ \_____  \         
      \ \  \_| \ \  \ \  \____\ \  \_|\ \|____|\  \        
       \ \__\   \ \__\ \_______\ \_______\____\_\  \       
        \|__|    \|__|\|_______|\|_______|\_________\      
                                         \|_________|      
                                                           
```

![OS - CachyOS](https://img.shields.io/badge/OS-CachyOS-04D7C4?style=for-the-badge&logo=archlinux&logoColor=white)
![OS - Ubuntu](https://img.shields.io/badge/OS-Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Editor - Neovim](https://img.shields.io/badge/Editor-Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Editor - Vim](https://img.shields.io/badge/Editor-Vim-019733?style=for-the-badge&logo=vim&logoColor=white)
![Shell - Zsh](https://img.shields.io/badge/Shell-Zsh-F1502F?style=for-the-badge&logo=zsh&logoColor=white)
![WM - Sway](https://img.shields.io/badge/WM-Sway-E81123?style=for-the-badge&logo=linux&logoColor=white)
![WM - i3](https://img.shields.io/badge/WM-i3wm-E84D31?style=for-the-badge&logo=i3&logoColor=white)
![Compositor - Picom](https://img.shields.io/badge/Compositor-Picom-101010?style=for-the-badge&logo=linux&logoColor=white)

---

### Overview
This repository serves as a **personal backup** and a **showcase** for my Linux configuration files. It features two distinct setups: a cutting-edge **CachyOS (Wayland/Sway)** environment and a polished **Ubuntu (X11)** backup.

[**Explore CachyOS Setup**](./cachyOS-config-files) • [**Explore Ubuntu Setup**](./ubuntu-config-files)

</div>

## CachyOS rice
my main setup optimized for performance and aesthetics

### key features
- **window manager:** [Sway](https://swaywm.org/) for a lightweight, modular Wayland experience.
- **visualizer:** Custom [Cava](https://github.com/karlstav/cava) setup featuring GLSL shaders (`northern_lights`, `eye_of_phi`).
- **custom terminal based DRPC:** Custom Discord Rich Presence scripts for specialized apps (ArduinoIDE, Kdenlive, Tinkercad).
- **scripts for both KDE plasma and sway WM:** 
    - `battery_sentinel.sh` for power monitoring.
    - `pomodoro-kclock.sh` for productivity tracking.
    - `focus.sh` for distraction-free work.
- **Terminal:** [Kitty](https://swapp.com/) with a curated theme collection.

<div align="center">
  <img src="gallery/3.png" width="48%">
  <img src="gallery/4.png" width="48%">
  <img src="cachyOS-config-files/gallery/spicetify.gif" width="48%">
  <img src="cachyOS-config-files/gallery/20251206_03h49m45s_grim.png" width="48%">
  <img src="cachyOS-config-files/gallery/nvim-kde.png" width="48%">
  <img src="cachyOS-config-files/gallery/wallpapers1.gif" width="48%">
  <img src="cachyOS-config-files/gallery/linux-rice1.gif" width="100%">
  <img src="https://github.com/user-attachments/assets/5ee6d357-328d-489f-9f37-2f01e6b6813d" width="48%">
  <img src="https://github.com/user-attachments/assets/fd915c6e-cd4b-4c7b-b7ae-509bd7a13fcb" width="48%">
  <img src="https://github.com/user-attachments/assets/0e3b7c01-7867-44c4-af56-4aeedb929930" width="100%">

</div>

---

## Ubuntu configs files
X11-based setup 

### key features
- **Compositor:** [Picom](https://github.com/yshui/picom) with blur and transparency configurations.
- **Fetch:** Custom [Neofetch](https://github.com/dylanaraps/neofetch) branding.
- **Terminal:** Pre-configured Kitty and Zsh environments.
- **Editor:** Classic Vim/Neovim backup configurations.

<div align="center">
  <img src="ubuntu-config-files/gallery/blue-themed.png" width="48%">
  <img src="ubuntu-config-files/gallery/black-white-themed.png" width="48%">
  <img src="ubuntu-config-files/gallery/skidmax.png" width="48%">
  <img src="ubuntu-config-files/gallery/white-setup.png" width="48%">
  <img src="cachyOS-config-files/gallery/old_nvim.png" width="48%">
  <img src="ubuntu-config-files/gallery/setup.png" width="48%">
</div>

---

## NVIM
fully modular lazy loaded config 

- **Package Manager:** [Lazy.nvim](https://github.com/folke/lazy.nvim) for sub-50ms startup.
- **Plugins:**
    - **status bar:** `lualine.lua` 
    - **file nav:** `oil.lua` (file manipulation), `telescope` (fuzzy finding), `bufferline.lua` (multiple tabs), `neotree.lua` (flexible file explorer)
    - **DRPC:** `cord.lua` for native Discord RPC integration.
    - **terminal** `cake.lua` for floating and dynamic terminal
- **theming:** dynamic theme switching via `themes.lua`.
- **core config:** `init.lua`
- **repo heatmaps and stats** `wrraped.lua`

for more info about my nvim set up you can visit this [repository](https://github.com/frtzhahn/nvim-setup)


