#!/usr/bin/bash

echo '*****************************************'
echo '*            Installing tmux            *'
echo '*****************************************'

# Install tmux
if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed tmux
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  sudo snap install tmux --classic
fi

# Clone Tmux Plugin Manager

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Create a symlink for the tmux configuration file

ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
