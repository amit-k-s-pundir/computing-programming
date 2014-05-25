#!/bin/bash

#tmux start-server
tmux new-session -d -s init-session -n "root-window"
#tmux attach-session -t init-session
tmux new-window -t init-session:1 -n "first-window" vim
tmux neww -t init-session:2 -n "second-window" vim
tmux neww -t init-session:3 -n "third-window" vim
tmux neww -t init-session:4 -n "fourth-window" vim
tmux attach-session -t init-session


