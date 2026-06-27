#!/bin/bash
# 1. Assassinate any old, overlapping swayidle background processes
pkill -x swayidle

# 2. Start the fresh timer engine
swayidle -w \
    timeout 1200000 'bash ~/.config/sway/lock.sh' \
    timeout 1800000 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' \
    timeout 1800000 'systemctl suspend' \
    before-sleep 'bash ~/.config/sway/lock.sh' \
    after-resume 'swaymsg "output * dpms on"'
