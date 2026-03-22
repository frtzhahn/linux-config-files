#!/bin/bash

START_TIME=$(date +%s)

# The JSON must remain on a single line for the parser.
while true; do
  echo '[{"application_id": 1485183041885442179, "details": "Planning out something...", "state": "IOT practice", "startTimestamp": '"$START_TIME"', "start_timestamp": '"$START_TIME"', "timestamps": {"start": '"$START_TIME"'}, "large_image": {"key": "tinkercad", "text": "IOT Practice area"}, "small_image": {"key": "arduino", "text": "doing arduino"}}]'
  sleep 15
done
