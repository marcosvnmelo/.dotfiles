#!/usr/bin/bash

echo '****************************************'
echo '*            Installing bat            *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed bat
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  mkdir -p "$INSTALL_TEMP_DIR"

  BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "\K[^"]*' | sed 's/v//')
  curl -Lo "$INSTALL_TEMP_DIR"/bat.deb \
    "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb"
  sudo dpkg -i "$INSTALL_TEMP_DIR"/bat.deb

  rm -rf "$INSTALL_TEMP_DIR"
fi
