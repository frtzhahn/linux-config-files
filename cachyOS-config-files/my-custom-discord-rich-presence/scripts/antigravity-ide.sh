#!/bin/bash

START_TIME=$(date +%s)

# The JSON must remain on a single line for the parser.
while true; do
  echo '[{"application_id": 1546819579039195237, "details": "Orchestrating frtzhahn'\''s project", "state": "on kitty terminal - zsh command line shell", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "agyide", "text": "yes i like google slop"}}]'
  sleep 15
done
