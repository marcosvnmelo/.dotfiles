#!/usr/bin/bash

echo '**************************************'
echo '*         Installing Ghostty         *'
echo '**************************************'

# Install ghostty

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S ghostty
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  # TODO: implement script
fi

# Create symbolic link for ghostty configuration file

mkdir -p ~/.config/ghostty

ln -s ~/.dotfiles/ghostty/config.conf ~/.config/ghostty/config

# Create symbolic link to gnome-terminal redirect to ghostty
if [[ $INSTALL_OS = 'arch' ]]; then
  sudo ln -s ~/.dotfiles/ghostty/fake-gnome-terminal.sh /usr/bin/gnome-terminal
fi

# Set ghostty as default terminal
# sudo update-alternatives --config x-terminal-emulator
