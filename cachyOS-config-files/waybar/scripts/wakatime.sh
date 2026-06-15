#!/bin/bash
# Retrieve token dynamically from ~/.wakatime.cfg or fallback to env var
token=$(sed -n 's/^api_key\s*=\s*//p' ~/.wakatime.cfg 2>/dev/null | tr -d '\r\n')
if [ -z "$token" ]; then
    token="$WAKATIME_API_KEY"
fi

if [ -z "$token" ]; then
    echo "{\"text\": \"  No Token\", \"tooltip\": \"WakaTime token not found in ~/.wakatime.cfg or env\"}"
    exit 0
fi

# Fetch today's coding time from WakaTime API
stats=$(curl -s -u "${token}:" https://wakatime.com/api/v1/users/current/status_bar/today)

if [ $? -eq 0 ]; then
    time_spent=$(echo "$stats" | jq -r '.data.grand_total.text' 2>/dev/null)
    if [ -n "$time_spent" ] && [ "$time_spent" != "null" ]; then
        echo "{\"text\": \">_ $time_spent\", \"tooltip\": \"WakaTime Coding Time Today\"}"
        exit 0
    fi
fi
echo "{\"text\": \"  N/A\", \"tooltip\": \"Offline or invalid token\"}"
