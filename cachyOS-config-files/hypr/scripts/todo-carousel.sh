#!/bin/bash
COUNT=$(todo.sh -p ls 2>/dev/null | grep -cE '^[0-9]+')
if [ "$COUNT" -gt 0 ]; then
    IDX=$(( ($(date +%s) / 10) % COUNT ))
    TASK=$(todo.sh -p ls 2>/dev/null | grep -E '^[0-9]+' | sed -E 's/^[0-9]+ //' | sed -n "$((IDX + 1))p")
    # echo "󰄲 Task $((IDX + 1))/$COUNT: $TASK"
		echo "Things left to do: $TASK"
else
    echo "󰄲 All tasks completed"
fi
