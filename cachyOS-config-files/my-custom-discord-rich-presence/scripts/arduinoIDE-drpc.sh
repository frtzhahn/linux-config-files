#!/bin/bash

START_TIME=$(date +%s)

# The JSON must remain on a single line for the parser.
while true; do
  echo '[{"application_id": 1485221838949974026, "details": "Doing IOT tasks", "state": "Modifying programs on Arduino Board", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "arduino", "text": "Arduino IDE"}, "small_image": {"key": "cpp", "text": "simplified C++"}}]'
  sleep 15
done
