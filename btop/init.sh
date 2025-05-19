#!/usr/bin/bash

echo '*****************************************'
echo '*            Installing btop            *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed btop
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  sudo snap install btop
fi
