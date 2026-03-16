#!/bin/bash

# Files to keep track of state
SUSPEND_FLAG="/tmp/battery_suspended"
LAST_NOTIFIED="/tmp/battery_last_notified"

# --- MOCK MODE FOR TESTING ---
# To test, run: TEST_CAPACITY=15 TEST_STATUS=Discharging ./battery_sentinel.sh
# ------------------------------

if [ ! -f "$LAST_NOTIFIED" ]; then
    echo "100" > "$LAST_NOTIFIED"
fi

while true; do
    # Get battery percentage and state (allow override for testing)
    CAPACITY=${TEST_CAPACITY:-$(cat /sys/class/power_supply/BAT0/capacity)}
    STATUS=${TEST_STATUS:-$(cat /sys/class/power_supply/BAT0/status)}

    # 1. Reset flags if we are charging
    if [ "$STATUS" = "Charging" ]; then
        rm -f "$SUSPEND_FLAG"
        echo "100" > "$LAST_NOTIFIED"
    fi

    # 2. Notification Logic (40, 30, 20, 10)
    if [ "$STATUS" = "Discharging" ]; then
        LAST_VAL=$(cat "$LAST_NOTIFIED")
        
        for LEVEL in 40 30 20 10; do
            if [ "$CAPACITY" -le "$LEVEL" ] && [ "$LAST_VAL" -gt "$LEVEL" ]; then
                if [ "$LEVEL" -eq 10 ]; then
                    notify-send -u critical "FINAL WARNING" "Battery at 10%! PLUG IN YOUR CHARGER NOW!"
                else
                    notify-send "Battery Warning" "Battery at ${CAPACITY}%! Please plug in your charger."
                fi
                echo "$LEVEL" > "$LAST_NOTIFIED"
            fi
        done

        # 3. The 15% Suspend Protocol
        if [ "$CAPACITY" -le 15 ] && [ ! -f "$SUSPEND_FLAG" ]; then
            notify-send -u critical "CRITICAL" "15% Battery reached. Suspending system now to protect battery..."
            sleep 2
            touch "$SUSPEND_FLAG"
            # Only suspend if NOT in test mode
            if [ -z "$TEST_CAPACITY" ]; then
                systemctl suspend
            else
                echo "DEBUG: System would have suspended here (Test Mode Active)."
            fi
        fi
    fi

    # If we are in test mode, exit after one loop
    if [ -n "$TEST_CAPACITY" ]; then
        exit 0
    fi

    sleep 60
done
