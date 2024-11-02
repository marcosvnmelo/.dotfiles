#!/usr/bin/bash

echo '****************************************'
echo '*            Installing zip            *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S zip unzip
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  sudo apt install zip unzip -y
fi
