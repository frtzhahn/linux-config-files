#!/bin/bash

START_TIME=$(date +%s)

# The JSON must remain on a single line for the parser.
while true; do
  echo '[{"application_id": 1492565643227168958, "details": "Working on: aldrin'\''s project", "state": "Workspace: linux environment", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "codex-color", "text": "Coding AI agent"}, "small_image": {"key": "openai", "text": "By Open AI"}}]'
  sleep 15
done
