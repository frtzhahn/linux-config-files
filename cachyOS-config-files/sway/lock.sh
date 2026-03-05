#!/bin/bash
# only triggers the lock effects if swaylock is NOT currently running
if ! pgrep -x swaylock > /dev/null; then
    swaylock -f --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --fade-in 1.5
fi
