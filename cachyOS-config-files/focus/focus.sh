#!/bin/bash

# Configuration
WORK_TIME="30m"
BREAK_TIME="5m"
SESSIONS=3
SOUND="/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
TITLE="Focus Session"

# Start the Loop
for ((i=1; i<=SESSIONS; i++))
do
	echo "LOCK IN BRO (session $i of $SESSIONS)"

    # 1. Work Timer
    if command -v timer &> /dev/null; then
        timer $WORK_TIME
    else
        echo "Timer starting for $WORK_TIME..."
        sleep $WORK_TIME
    fi

    # Work Session Finished Alert
    notify-send "$TITLE" "Session $i done. Get out of the screen now" -i appointment-soon
    [ -f "$SOUND" ] && paplay "$SOUND" || echo -e "\a"

    # 2. Break Timer (Only if it's not the last session)
    if [ $i -lt $SESSIONS ]; then
        echo "Break starting: $BREAK_TIME"
        if command -v timer &> /dev/null; then
            timer $BREAK_TIME
        else
            sleep $BREAK_TIME
        fi
        
        # Break Finished Alert
        notify-send "Break Over" "Get back to work! Session $((i+1)) starting now." -i dialog-information
        [ -f "$SOUND" ] && paplay "$SOUND" || echo -e "\a"
    fi
done

echo "all 3 sessions complete. good job ig"
