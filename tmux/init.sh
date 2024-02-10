#!/usr/bin/bash

echo 'Installing tmux'

# Create a symlink for the tmux configuration file

ln -s $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
