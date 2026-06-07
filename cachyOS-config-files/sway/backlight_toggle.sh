#!/bin/bash
# Script to locate, toggle, and persistently monitor the backlight of the c0f4:0ff5 USB Keyboard.

PID_FILE="/tmp/kb_backlight.pid"
VENDOR_PRODUCT="C0F4:0FF5"

# Function to isolate the exact sysfs device name dynamically
find_device() {
    for dev in /sys/class/leds/*::scrolllock; do
        if [ -e "$dev" ]; then
            if [[ "$(readlink -f "$dev")" == *$VENDOR_PRODUCT* ]]; then
                basename "$dev"
                return 0
            fi
        fi
    done
    return 1
}

dev_name=$(find_device)
if [ -z "$dev_name" ]; then
    echo "Error: Keyboard device (c0f4:0ff5) scrolllock LED interface not found in sysfs."
    exit 1
fi

# Background daemon function to fight the kernel state reset
run_monitor() {
    while true; do
        current_state=$(brightnessctl --device="$dev_name" g)
        if [ "$current_state" -eq 0 ]; then
            brightnessctl --device="$dev_name" set 1
        fi
        sleep 0.1  # Check every 100ms for instant correction with 0% CPU impact
    done
}

# Core Toggle Logic
if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
    # Monitor daemon is active -> Kill it and turn off the backlight
    PID=$(cat "$PID_FILE")
    kill "$PID" 2>/dev/null
    rm -f "$PID_FILE"
    brightnessctl --device="$dev_name" set 0
    echo "Backlight turned OFF and background monitor stopped."
else
    # Monitor daemon is dead/inactive -> Force ON and start the daemon
    brightnessctl --device="$dev_name" set 1
    
    # Spin up the monitor loop in the background and record its process ID
    run_monitor &
    echo $! > "$PID_FILE"
    echo "Backlight turned ON and background monitor started."
fi
