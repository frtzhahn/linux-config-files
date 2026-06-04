#!/bin/bash
# Script to locate and toggle the backlight of the c0f4:0ff5 USB Keyboard without sudo.

# Iterate over all scrolllock LED directories in sysfs
for dev in /sys/class/leds/*::scrolllock; do
    if [ -e "$dev" ]; then
        # Resolve the absolute physical path of the LED directory
        real_path=$(readlink -f "$dev")
        
        # Check if the resolved path belongs to the vendor:product ID (C0F4:0FF5)
        if [[ "$real_path" == *C0F4:0FF5* ]]; then
            # Extract the device folder name (e.g., input330::scrolllock)
            dev_name=$(basename "$dev")
            
            # Get the current brightness state (0 or 1)
            current_state=$(brightnessctl --device="$dev_name" g)

            # Check and toggle the state dynamically
            if [ "$current_state" -eq 0 ]; then
                brightnessctl --device="$dev_name" set 1
                echo "Backlight turned ON."
            else
                brightnessctl --device="$dev_name" set 0
                echo "Backlight turned OFF."
            fi
            exit 0
        fi
    fi
done

echo "Error: Keyboard device (c0f4:0ff5) scrolllock LED interface not found in sysfs."
exit 1
