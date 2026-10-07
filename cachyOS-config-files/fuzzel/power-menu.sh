#!/usr/bin/env bash

LOCK=" Lock"
LOGOUT=" Logout"
SUSPEND=" Suspend"
REBOOT=" Reboot"
SHUTDOWN=" Shutdown"

CHOICE=$(echo -e "$LOCK\n$LOGOUT\n$SUSPEND\n$REBOOT\n$SHUTDOWN" | fuzzel --dmenu)

case "$CHOICE" in
    "$LOCK")
				hyprlock -c ~/.config/hypr/hyprlock-idle.conf
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
