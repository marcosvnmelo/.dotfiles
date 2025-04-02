#!/usr/bin/bash

echo '*****************************************'
echo '*            Installing tmux            *'
echo '*****************************************'

# Install tmux
if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S tmux
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  sudo snap install tmux --classic
fi

# Clone Tmux Plugin Manager

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Create a symlink for the tmux configuration file

ln -s "$HOME"/.dotfiles/tmux/.tmux.conf "$HOME"/.tmux.conf
