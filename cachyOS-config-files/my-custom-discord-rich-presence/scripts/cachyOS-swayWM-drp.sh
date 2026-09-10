#!/bin/bash

# Grab the exact Unix timestamp in seconds
START_TIME=$(date +%s)

# We are testing the raw API format, the C-struct format, and the snake_case format.
while true; do
  echo '[{"application_id": 1485189428946403359, "details": "Linux distro currently in use", "state": "on Dell laptop", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "cachyos", "text": "Arch based "}, "small_image": {"key": "swaywm", "text": "using swayWM"}}]'
  sleep 15
done
