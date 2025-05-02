#!/usr/bin/bash

echo '*****************************************'
echo '*            Installing btop            *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S btop
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  sudo snap install btop
fi
