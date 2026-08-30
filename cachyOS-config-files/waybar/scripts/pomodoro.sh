#!/bin/bash
# ==============================================================================
# Pomodoro Timer Engine for Waybar
# ==============================================================================
# Configure intervals below (values in minutes):
WORK_TIME=90               # Duration of work session (minutes)
SHORT_BREAK=15             # Duration of short break (minutes)
LONG_BREAK=30             # Duration of long break (minutes)
SESSIONS_BEFORE_LONG=3    # Work sessions before a long break

# Sound file path for alerts (headless playback via mpv)
SOUND_FILE="${HOME}/.config/waybar/sounds/radial.mp3"

# Waybar Real-Time Signal to trigger instant UI refresh
WAYBAR_SIGNAL=8

# State file location
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}"
STATE_FILE="${STATE_DIR}/waybar_pomodoro.state"
LOCK_FILE="${STATE_DIR}/waybar_pomodoro.lock"

# Default state initialization
init_state() {
    STATE="work"
    IS_PAUSED=1
    REMAINING=$((WORK_TIME * 60))
    END_TIME=$(($(date +%s) + REMAINING))
    SESSION_COUNT=0
    save_state
}

# Save state to persistent file
save_state() {
    cat <<EOF > "$STATE_FILE"
STATE="$STATE"
IS_PAUSED=$IS_PAUSED
REMAINING=$REMAINING
END_TIME=$END_TIME
SESSION_COUNT=$SESSION_COUNT
EOF
}

# Load state from persistent file
load_state() {
    if [ -f "$STATE_FILE" ]; then
        # shellcheck disable=SC1090
        source "$STATE_FILE"
    else
        init_state
    fi
}

# Send Real-Time signal to Waybar for zero-latency refresh
signal_waybar() {
    pkill -RTMIN+${WAYBAR_SIGNAL} waybar 2>/dev/null || true
}

# Notification helper
send_notification() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"
    if command -v notify-send >/dev/null 2>&1; then
        notify-send -u "$urgency" -a "Pomodoro Timer" "$title" "$message"
    fi
}

# Sound alert helper (headless background playback via mpv)
play_alarm() {
    if [ -n "$SOUND_FILE" ] && [ -f "$SOUND_FILE" ] && command -v mpv >/dev/null 2>&1; then
        mpv --no-video --really-quiet "$SOUND_FILE" >/dev/null 2>&1 &
    fi
}

# Toggle pause / resume state
toggle() {
    exec 200>"$LOCK_FILE"
    flock -x 200

    load_state
    local current_time
    current_time=$(date +%s)

    if [ "$IS_PAUSED" -eq 1 ]; then
        # Resume timer
        IS_PAUSED=0
        END_TIME=$((current_time + REMAINING))
        save_state
    else
        # Pause timer
        IS_PAUSED=1
        REMAINING=$((END_TIME - current_time))
        if [ "$REMAINING" -lt 0 ]; then
            REMAINING=0
        fi
        save_state
    fi

    flock -u 200
    signal_waybar
}

# Reset timer to initial work state
reset_timer() {
    exec 200>"$LOCK_FILE"
    flock -x 200

    init_state

    flock -u 200
    signal_waybar
}

# Skip current session and proceed to the next
skip_session() {
    exec 200>"$LOCK_FILE"
    flock -x 200

    load_state
    if [ "$STATE" = "work" ]; then
        SESSION_COUNT=$((SESSION_COUNT + 1))
        if [ $((SESSION_COUNT % SESSIONS_BEFORE_LONG)) -eq 0 ]; then
            STATE="long_break"
            REMAINING=$((LONG_BREAK * 60))
        else
            STATE="short_break"
            REMAINING=$((SHORT_BREAK * 60))
        fi
    else
        STATE="work"
        REMAINING=$((WORK_TIME * 60))
    fi

    IS_PAUSED=1
    END_TIME=$(($(date +%s) + REMAINING))
    save_state

    flock -u 200
    signal_waybar
}

# Output JSON status for Waybar ingestion
get_status() {
    exec 200>"$LOCK_FILE"
    flock -x 200

    load_state
    local current_time
    current_time=$(date +%s)

    if [ "$IS_PAUSED" -eq 0 ]; then
        REMAINING=$((END_TIME - current_time))

        # Check for session completion
        if [ "$REMAINING" -le 0 ]; then
            if [ "$STATE" = "work" ]; then
                SESSION_COUNT=$((SESSION_COUNT + 1))
                if [ $((SESSION_COUNT % SESSIONS_BEFORE_LONG)) -eq 0 ]; then
                    STATE="long_break"
                    REMAINING=$((LONG_BREAK * 60))
                    send_notification "Work Iteration Complete" "${LONG_BREAK} - minute long break."
                else
                    STATE="short_break"
                    REMAINING=$((SHORT_BREAK * 60))
                    send_notification "Work Session Complete" "${SHORT_BREAK} - minute short break." 
                fi
            else
                STATE="work"
                REMAINING=$((WORK_TIME * 60))
                send_notification "Break Ended" "back to grind" 
            fi

            play_alarm
            IS_PAUSED=1
            END_TIME=$((current_time + REMAINING))
            save_state
        fi
    fi

    # Format time MM:SS
    local display_seconds=$REMAINING
    if [ "$display_seconds" -lt 0 ]; then
        display_seconds=0
    fi
    local minutes=$((display_seconds / 60))
    local seconds=$((display_seconds % 60))
    local formatted_time
    formatted_time=$(printf "%02d:%02d" "$minutes" "$seconds")

    # Determine icon, tooltip, and CSS class
    local text=""
    local tooltip=""
    local class=""

    if [ "$IS_PAUSED" -eq 1 ]; then
        class="paused"
        if [ "$STATE" = "work" ]; then
            text="󰏤 ${formatted_time}"
            tooltip="Work - Paused Session: #${SESSION_COUNT}"
        elif [ "$STATE" = "short_break" ]; then
            text="󰏤 ${formatted_time}"
            tooltip="Short Break - Paused Session: #${SESSION_COUNT}"
        else
            text="󰏤 ${formatted_time}"
            tooltip="Long Break - Paused Session: #${SESSION_COUNT}"
        fi
    else
        if [ "$STATE" = "work" ]; then
            class="work"
            text="󰔛 ${formatted_time}"
            tooltip="Work - Running Session: #${SESSION_COUNT}"
        elif [ "$STATE" = "short_break" ]; then
            class="break"
            text="\uf0f4 ${formatted_time}"
            tooltip="Short Break - Running Session: #${SESSION_COUNT}"
        else
            class="break"
            text="󰒲  ${formatted_time}"
            tooltip="Long Break - Running Session: #${SESSION_COUNT}"
        fi
    fi

    flock -u 200

    # Output formatted JSON for Waybar
    printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$text" "$tooltip" "$class"
}

# Main Command Dispatcher
case "$1" in
    toggle)
        toggle
        ;;
    reset)
        reset_timer
        ;;
    skip)
        skip_session
        ;;
    status|*)
        get_status
        ;;
esac
