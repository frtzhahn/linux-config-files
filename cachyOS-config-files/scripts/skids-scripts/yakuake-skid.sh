#!/bin/bash

# If a tmux session already exists, attach to it
if tmux has-session -t yakuake 2>/dev/null; then
    exec tmux attach-session -t yakuake
fi

# Otherwise create a new session with 4 panes
tmux new-session -d -s yakuake 'cbonsai -l'
tmux split-window -h 'rain'
tmux split-window -v 'asciiquarium'
tmux select-pane -t 0
tmux split-window -v 'cd pipes && ./pipes.sh'

# Attach to the created session
exec tmux attach-session -t yakuake

