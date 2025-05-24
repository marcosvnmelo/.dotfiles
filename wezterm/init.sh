#!/usr/bin/bash

echo '**************************************'
echo '*         Installing wezterm         *'
echo '**************************************'

# Install wezterm

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S --noconfirm --needed wezterm-git
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  if [[ -z $(which wezterm) ]]; then
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg

    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
  fi

  sudo apt update -y && sudo apt install wezterm-nightly -y
fi

# Create symbolic link for wezterm configuration file

mkdir -p ~/.config/wezterm

ln -sf ~/.dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

# Create symbolic link to gnome-terminal redirect to wezterm
if [[ $INSTALL_OS = 'arch' ]]; then
  sudo ln -sf ~/.dotfiles/wezterm/fake-gnome-terminal.sh /usr/bin/gnome-terminal
fi

# Set wezterm as default terminal
# sudo update-alternatives --config x-terminal-emulator
