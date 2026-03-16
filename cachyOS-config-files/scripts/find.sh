#!/bin/bash

# Directory to scan (default is current)
DIR="${1:-.}"

find "$DIR" | while read -r file; do
    echo "$file"
    sleep 0.1   # adjust speed here
done
