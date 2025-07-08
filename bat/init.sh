#!/usr/bin/bash

echo '****************************************'
echo '*            Installing bat            *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed bat
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  mkdir -p /tmp/dotfiles

  BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "\K[^"]*' | sed 's/v//')
  curl -L "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/ bat-musl_${BAT_VERSION}_musl-linux-amd64.deb " \
    -o /tmp/dotfiles/bat.deb

  sudo dpkg -i /tmp/dotfiles/bat.deb

  rm -rf /tmp/dotfiles
fi
