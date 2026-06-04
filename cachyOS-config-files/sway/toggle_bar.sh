#!/bin/bash

# Check if swaybar is currently running
if pgrep -x "swaybar" > /dev/null; then
    # Kill the bar
    killall swaybar
    # Explicitly kill bumblebee-status to ensure the RAM is freed immediately
    killall bumblebee-status 2>/dev/null
else
    # Launch swaybar using the ID from the config
    swaybar -b bar-0 &
fi
