#!/usr/bin/bash

echo '*****************************************'
echo '*            Installing tmux            *'
echo '*****************************************'

# Clone Tmux Plugin Manager

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Create a symlink for the tmux configuration file

ln -s $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
