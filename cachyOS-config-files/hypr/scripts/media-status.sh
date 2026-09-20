#!/bin/bash
STATUS=$(playerctl status 2>/dev/null)
if [ "$STATUS" = "Playing" ]; then
    TITLE=$(playerctl metadata --format "{{ title }}" 2>/dev/null)
    ARTIST=$(playerctl metadata --format "{{ artist }}" 2>/dev/null)
    if [ -n "$ARTIST" ]; then
        echo "󰝚  $TITLE  •  $ARTIST"
    else
        echo "󰝚  $TITLE"
    fi
else
    LC_TIME=en_US.UTF-8 date +"%A, %B %d"
fi
