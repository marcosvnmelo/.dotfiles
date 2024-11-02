#!/usr/bin/bash

echo '**************************************'
echo '*         Installing wezterm         *'
echo '**************************************'

# Install wezterm

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | yay -S wezterm-git
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg

  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

  sudo apt update -y

  sudo apt install wezterm-nightly -y
fi

# Create symbolic link for wezterm configuration file

mkdir -p "$HOME"/.config/wezterm

ln -s "$HOME"/.dotfiles/wezterm/wezterm.lua "$HOME"/.config/wezterm/wezterm.lua

# Set wezterm as default terminal
# sudo update-alternatives --config x-terminal-emulator
