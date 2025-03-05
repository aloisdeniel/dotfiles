#!/bin/bash

session_name="$1"

if [ -z "$session_name" ] ; then
  echo "Session name is required."
  exit 1
fi

tmux has-session -t $session_name
if [ $? != 0 ]
then
  # SESSION
  tmux new-session               -ds $session_name

  # THEMING
  tmux set                        -g status-style bg=blue,fg=black
  tmux set                        -g window-status-style fg=colour16
  tmux set                        -g window-status-current-style fg=black

  # W1 : Editor
  tmux rename-window              -t $session_name:1   nvim
  tmux set-window-option          -t $session_name:1   allow-rename off
  tmux send-keys                  -t $session_name:1   'nvim' C-m

  # W2 : Flutter Execution
  tmux new-window                 -t $session_name:2
  tmux set-window-option          -t $session_name:2   allow-rename off
  tmux rename-window              -t $session_name:2   flutter
  tmux send-keys                  -t $session_name:2   'flutter run'

  # W3 : LazyGit
  tmux new-window                 -t $session_name:3
  tmux set-window-option          -t $session_name:3   allow-rename off
  tmux rename-window              -t $session_name:3   lazygit
  tmux send-keys                  -t $session_name:3   'lazygit' C-m

  # W3 : Terminal
  tmux new-window                 -t $session_name:4
  tmux set-window-option          -t $session_name:4   allow-rename off
  tmux rename-window              -t $session_name:4   terminal

  tmux select-window              -t $session_name:1
fi

tmux attach -t $session_name
