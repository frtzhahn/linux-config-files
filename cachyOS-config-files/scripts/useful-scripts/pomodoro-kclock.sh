#!/bin/bash
# ============================================
#  Pomodoro Timer — KClock + KDE Plasma
# ============================================

WORK_MINUTES=25
BREAK_MINUTES=5

WORK_SECONDS=$((WORK_MINUTES * 60))
BREAK_SECONDS=$((BREAK_MINUTES * 60))
SESSION=1
TIMER_PATH=""

# ---- Create a new timer with a dynamic label ----
create_timer() {
    local SECONDS="$1"
    local LABEL="$2"

    local BEFORE
    BEFORE=$(qdbus6 org.kde.kclockd /Timers \
        org.kde.kclock.TimerModel.timers 2>/dev/null | tr ' ' '\n' | sort)

    qdbus6 org.kde.kclockd /Timers \
        org.kde.kclock.TimerModel.addTimer \
        "$SECONDS" "$LABEL" false "" false 2>/dev/null

    sleep 0.3

    local AFTER
    AFTER=$(qdbus6 org.kde.kclockd /Timers \
        org.kde.kclock.TimerModel.timers 2>/dev/null | tr ' ' '\n' | sort)

    local UUID
    UUID=$(comm -13 <(echo "$BEFORE") <(echo "$AFTER") | head -1)

    if [[ -n "$UUID" ]]; then
        TIMER_PATH="/Timers/${UUID}"
        # Start the timer
        qdbus6 org.kde.kclockd "$TIMER_PATH" \
            org.kde.kclock.Timer.toggleRunning 2>/dev/null
    else
        echo "  ↳ [error] Could not create timer"
        exit 1
    fi
}

# ---- Delete the current timer ----
delete_timer() {
    if [[ -n "$TIMER_PATH" ]]; then
        qdbus6 org.kde.kclockd "$TIMER_PATH" \
            org.kde.kclock.Timer.reset 2>/dev/null

        local UUID="${TIMER_PATH#/Timers/}"
        qdbus6 org.kde.kclockd /Timers \
            org.kde.kclock.TimerModel.removeTimer "$UUID" 2>/dev/null
        
        TIMER_PATH=""
    fi
}

# ---- Cleanup on Ctrl+C (Reverted to original) ----
cleanup() {
    echo -e "\n⛔ Pomodoro stopped."

    local COMPLETED=$((SESSION - 1))

    if [[ -n "$TIMER_PATH" ]]; then
        qdbus6 org.kde.kclockd "$TIMER_PATH" \
            org.kde.kclock.Timer.reset 2>/dev/null

        local UUID="${TIMER_PATH#/Timers/}"
        qdbus6 org.kde.kclockd /Timers \
            org.kde.kclock.TimerModel.removeTimer "$UUID" 2>/dev/null

        echo "🗑️  Timer removed from KClock."
    fi

    if [[ $COMPLETED -eq 1 ]]; then
        local SESSION_TEXT="1 session completed"
    elif [[ $COMPLETED -eq 0 ]]; then
        local SESSION_TEXT="no full sessions completed"
    else
        local SESSION_TEXT="${COMPLETED} sessions completed"
    fi

    notify-send "🍅 Pomodoro Ended" \
        "Good work! ${SESSION_TEXT}." \
        --icon="kclock" \
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
    echo "🎯 Session $SESSION — Work Time (${WORK_MINUTES} min)"
    create_timer "$WORK_SECONDS" "🎯 Work — Session $SESSION"
    sleep "$WORK_SECONDS"
    delete_timer

    # ---- BREAK PHASE ----
    echo "☕ Session $SESSION — Break Time (${BREAK_MINUTES} min)"
    create_timer "$BREAK_SECONDS" "☕ Break — Session $SESSION"
    sleep "$BREAK_SECONDS"
    delete_timer

    SESSION=$((SESSION + 1))
done
