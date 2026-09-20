#!/bin/bash
# prevents swayidle stacking
pkill -x swayidle

# sway idle timer/config
swayidle -w \
    timeout 600 'hyprlock -c /home/mocha/.config/hypr/hyprlock-idle.conf' \
    timeout 3600000 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' \
    timeout 3600 'systemctl suspend' \
    before-sleep 'pgrep -x hyprlock || (hyprlock --immediate-render -c /home/mocha/.config/hypr/hyprlock-macos.conf & sleep 0.1)' \
    after-resume 'swaymsg "output * dpms on"'
