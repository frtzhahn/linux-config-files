#!/bin/bash
# Retrieve token dynamically from ~/.wakatime.cfg or fallback to env var
token=$(sed -n 's/^api_key\s*=\s*//p' ~/.wakatime.cfg 2>/dev/null | tr -d '\r\n')
if [ -z "$token" ]; then
    token="$WAKATIME_API_KEY"
fi

if [ -z "$token" ]; then
    echo "{\"text\": \"(ㄒoㄒ) No Token\", \"tooltip\": \"WakaTime token not found in ~/.wakatime.cfg or env\"}"
    exit 0
fi

# Fetch today's coding time from WakaTime API
stats=$(curl -s -u "${token}:" https://wakatime.com/api/v1/users/current/status_bar/today)

if [ $? -eq 0 ]; then
    time_spent=$(echo "$stats" | jq -r '.data.grand_total.text' 2>/dev/null)
    total_seconds=$(echo "$stats" | jq -r '.data.grand_total.total_seconds' 2>/dev/null)

    if [ -n "$time_spent" ] && [ "$time_spent" != "null" ] && [ -n "$total_seconds" ] && [ "$total_seconds" != "null" ]; then
        # Convert float to integer for bash comparisons
        total_seconds_int=$(printf "%.0f" "$total_seconds" 2>/dev/null || echo 0)

        # 5-Stage Emoticon Progression (3-Hour / 10800s Goal)
        if [ "$total_seconds_int" -lt 1800 ]; then
            emoticon="(｡•́︿•̀｡)"      # Stage 1: 0 - 30 mins (Sad / Cold Start)
        elif [ "$total_seconds_int" -lt 3600 ]; then
            emoticon="(￢_￢)"        # Stage 2: 30 mins - 1 hour (Determined / Warmed Up)
        elif [ "$total_seconds_int" -lt 7200 ]; then
            emoticon="(¬‿¬)"    # Stage 3: 1 hour - 2 hours (Sustained / Happy)
        elif [ "$total_seconds_int" -lt 10800 ]; then
            emoticon="(˶˃ ᵕ ˂˶)"      # Stage 4: 2 hours - 3 hours (Flow State / Excited)
        elif [ "$total_seconds_int" -lt 14400 ]; then
            emoticon="(＾▽＾)"      # Stage 5: 3 hours - 4 hours (Flow State / Excited)
        elif [ "$total_seconds_int" -lt 18000 ]; then
            emoticon="( ˶ˆᗜˆ˵ )"      # Stage 6: 4 hours - 5 hours (Flow State / Excited)
        else
            emoticon="⊹ ₊  ⁺‧₊˚ ♡"  # Stage 7: >= 5 hours (Goal Achieved! Star Power)
        fi

        echo "{\"text\": \"$emoticon $time_spent\", \"tooltip\": \"WakaTime Coding Time Today\"}"
        exit 0
    fi
fi
echo "{\"text\": \"(ￗ﹏ￗ) N/A\", \"tooltip\": \"Offline or invalid token\"}"
