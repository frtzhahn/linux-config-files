#!/bin/bash

# If a tmux session already exists, attach to it
if tmux has-session -t yakuake 2>/dev/null; then
    exec tmux attach-session -t yakuake
fi

# Otherwise create a new session with 4 panes
tmux new-session -d -s yakuake 'cmatrix -C white'
tmux split-window -h 'glances'
tmux split-window -v 'tty-clock -D -c -C 7'
tmux select-pane -t 0
tmux split-window -v 'cava'

# Attach to the created session
exec tmux attach-session -t yakuake

