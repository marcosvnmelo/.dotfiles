#!/usr/bin/bash

echo '****************************************'
echo '*            Installing bat            *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed bat
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  curl -L 'https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb' -o 'bat.deb'

  sudo dpkg -i bat.deb

  rm bat.deb
fi
