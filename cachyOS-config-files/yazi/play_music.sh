#!/bin/bash

# 1. Kill the specific background player using its unique title.
# We silence errors (2>/dev/null) in case no music is playing yet.
pkill -f "title=yazi_music_player" 2>/dev/null

# 2. Start the new song.
# We give it the unique title "yazi_music_player" so we can kill it next time.
# "exec" replaces this script with mpv, keeping things clean.
exec mpv --title="yazi_music_player" --no-video "$1"
