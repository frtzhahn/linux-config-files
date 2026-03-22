#!/bin/bash

START_TIME=$(date +%s)

# The JSON must remain on a single line for the parser.
while true; do
  echo '[{"application_id": 1485194553416880238, "details": "Orchestrating aldrin'\''s project", "state": "on kitty terminal - zsh command-line shell", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "gemini", "text": "Senior Software Engineer on a terminal"}, "small_image": {"key": "cli-logo", "text": "goated CLI"}}]'
  sleep 15
done
