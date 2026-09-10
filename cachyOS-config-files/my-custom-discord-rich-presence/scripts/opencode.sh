#!/bin/bash

START_TIME=$(date +%s)

# The JSON must remain on a single line for the parser.
while true; do
  echo '[{"application_id": 1546837560473423902, "details": "Workin on some random ahh project", "state": "Tokenmaxxxxing", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "opencode", "text": "free tier abuser"}}]'
  sleep 15
done
