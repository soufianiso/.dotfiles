#!/bin/bash

# Directory where your Tmuxifier layouts are stored
LAYOUT_DIR="$HOME/.tmuxifier/layouts"

# Use fzf to select a layout
LAYOUT=$(tmuxifier ls | fzf)

# If a layout was selected, load it
if [ -n "$LAYOUT" ]; then
  tmuxifier load-session "$(basename "$LAYOUT")"
  tmux switch-client -t $LAYOUT

fi

