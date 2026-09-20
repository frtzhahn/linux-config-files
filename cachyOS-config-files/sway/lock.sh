#!/bin/bash
# Only trigger the lock screen if hyprlock is NOT currently running
if ! pgrep -x hyprlock > /dev/null; then
    hyprlock
fi
