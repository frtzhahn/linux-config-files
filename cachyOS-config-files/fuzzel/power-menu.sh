#!/usr/bin/env bash

LOCK=" Lock"
LOGOUT=" Logout"
SUSPEND=" Suspend"
REBOOT=" Reboot"
SHUTDOWN=" Shutdown"

CHOICE=$(echo -e "$LOCK\n$LOGOUT\n$SUSPEND\n$REBOOT\n$SHUTDOWN" | fuzzel --dmenu)

case "$CHOICE" in
    "$LOCK")
        pgrep -x swaylock || swaylock -f --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --fade-in 1.5
        ;;
    "$LOGOUT")
        swaymsg exit
        ;;
    "$SUSPEND")
        systemctl suspend
        ;;
    "$REBOOT")
        systemctl reboot
        ;;
    "$SHUTDOWN")
        systemctl poweroff
        ;;
esac
