#!/bin/bash
# ============================================
#  Pomodoro Timer — Terminal + notify-send
# ============================================

WORK_MINUTES=25
BREAK_MINUTES=5

WORK_SECONDS=$((WORK_MINUTES * 60))
BREAK_SECONDS=$((BREAK_MINUTES * 60))
SESSION=1

# ---- Terminal Countdown Function ----
countdown() {
    local seconds=$1
    local label=$2

    while [ "$seconds" -gt 0 ]; do
        # Format as MM:SS and print on the same line using \r
        printf "\r  %s [%02d:%02d] " "$label" $((seconds / 60)) $((seconds % 60))
        sleep 1
        : $((seconds--))
    done
    # Print 00:00 when finished, then move to a new line
    printf "\r  %s [00:00]\n" "$label"
}

# ---- Cleanup on Ctrl+C ----
cleanup() {
    echo -e "\n\n⛔ Pomodoro stopped."

    local COMPLETED=$((SESSION - 1))

    if [[ $COMPLETED -eq 1 ]]; then
        local SESSION_TEXT="1 session completed"
    elif [[ $COMPLETED -eq 0 ]]; then
        local SESSION_TEXT="no full sessions completed"
    else
        local SESSION_TEXT="${COMPLETED} sessions completed"
    fi

    # Final summary notification
    notify-send "🍅 Pomodoro Ended" \
        "Good work! ${SESSION_TEXT}." \
        --icon="dialog-information" \
        --urgency=normal \
        --app-name="Pomodoro"

    echo "📊 Total sessions completed: $COMPLETED"
    echo "👋 See you next time!"
    exit 0
}
trap cleanup SIGINT SIGTERM

# ---- Start ----
echo "================================================"
echo "  🍅 Pomodoro Timer Started"
echo "  Work: ${WORK_MINUTES} min  |  Break: ${BREAK_MINUTES} min"
echo "  Press Ctrl+C to stop"
echo "================================================"

while true; do
    # ---- WORK PHASE ----
    echo ""
    countdown "$WORK_SECONDS" "🎯 Work — Session $SESSION"
    
    # Notify when Work is over
    notify-send "🎯 Work Finished!" \
        "Session $SESSION complete. Take a ${BREAK_MINUTES} minute break." \
        --icon="face-smile" \
        --urgency=critical \
        --app-name="Pomodoro"

    # ---- BREAK PHASE ----
    countdown "$BREAK_SECONDS" "☕ Break — Session $SESSION"
    
    # Notify when Break is over
    notify-send "⏰ Break Over!" \
        "Time to get back to work for Session $((SESSION + 1))." \
        --icon="appointment-new" \
        --urgency=critical \
        --app-name="Pomodoro"

    SESSION=$((SESSION + 1))
done
