#!/usr/bin/bash

echo '***************************************'
echo '*           Installing Yazi           *'
echo '***************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S yazi ffmpegthumbnailer ffmpeg p7zip jq poppler imagemagick
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  # TODO: implement script
  echo 'Not implemented yet'
fi

# Create config directory
mkdir -p ~/.config/yazi/plugins/
ln -s ~/.dotfiles/yazi/keymap.toml ~/.config/yazi/keymap.toml
ln -s ~/.dotfiles/yazi/init.lua ~/.config/yazi/init.lua

# Install plugins
ya pack -a Lil-Dank/lazygit
ya pack -a Rolv-Apneseth/starship
ya pack -a yazi-rs/plugins:full-border
