#!/bin/bash

START_TIME=$(date +%s)

# The JSON must remain on a single line for the parser.
while true; do
  echo '[{"application_id": 1485158308208709643, "details": "Linux Distro - CachyOS", "state": "Editing a Video", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "kdenlive", "text": "Linux video editing tool"}, "small_image": {"key": "kdenlive", "text": "alternative to DaVinci"}}]'
  sleep 15
done
