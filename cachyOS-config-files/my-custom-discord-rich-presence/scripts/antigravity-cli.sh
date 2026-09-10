#!/bin/bash

START_TIME=$(date +%s)

# The JSON must remain on a single line for the parser.
while true; do
  echo '[{"application_id": 1546821771641098351, "details": "Working on frtzhahn'\''s project", "state": "Sandbox Environment", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "agycli", "text": "yes i like google slop"}}]'
  sleep 15
done
