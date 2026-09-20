#!/bin/bash
# ==============================================================================
# HYPRLOCK THEME SWITCHER
# ==============================================================================
# Usage: bash ~/.config/hypr/switch-theme.sh {macos|minimal}

THEME="$1"
case "$THEME" in
    macos)
        ln -sf /home/mocha/.config/hypr/hyprlock-macos.conf /home/mocha/.config/hypr/hyprlock.conf
        echo "Active hyprlock theme set to: macOS Sonoma"
        ;;
    minimal)
        ln -sf /home/mocha/.config/hypr/hyprlock-minimal.conf /home/mocha/.config/hypr/hyprlock.conf
        echo "Active hyprlock theme set to: Minimalist Pill"
        ;;
    idle)
        ln -sf /home/mocha/.config/hypr/hyprlock-idle.conf /home/mocha/.config/hypr/hyprlock.conf
        echo "Active hyprlock theme set to: idle"
        ;;
    *)
        echo "Usage: $0 {macos|minimal|idle}"
        exit 1
        ;;
esac
