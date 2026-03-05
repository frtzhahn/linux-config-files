#!/bin/bash
# prevents overlapping swayidle background processes
pkill -x swayidle

# starts the fresh timer engine
swayidle -w \
    timeout 300 'bash ~/.config/sway/lock.sh' \
    timeout 600 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' \
    timeout 900 'systemctl suspend' \
    before-sleep 'bash ~/.config/sway/lock.sh' \
    after-resume 'swaymsg "output * dpms on"'
