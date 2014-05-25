#!/usr/bin/perl

use strict;

sub set_up_tmux{
    `tmux new-session -d -s "init-session1" -n "root-window"`;
    `tmux new-window -t "init-session1:1"`;
    `tmux new-window -t "init-session1:2"`;
    `tmux new-window -t "init-session1:3"`;
    `tmux new-window -t "init-session1:4"`;
    `tmux new-window -t "init-session1:5"`;
    `tmux new-window -t "init-session1:6"`;
    `tmux new-window -t "init-session1:7"`;
    `tmux select-window -t "init-session1:1"`;
    `tmux send-keys "emacs &" "Enter" `;
#    `tmux -c /opt/emacs/bin/emacs &`;
    `tmux attach-session -t "init-session1"`;
    
    my ($numberOfWindows) = @_;
    for my $x (0 .. $numberOfWindows - 1){
	#	`tmux attach -d -t init-session`;
	#	`tmux new-window`;
    }
}

sub set_up_network_shares{
}

set_up_tmux(7);
#`tmux new-window -n "vim-window" vim`;
