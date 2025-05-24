#!/usr/bin/bash

echo '*************************************'
echo '*           Installing jq           *'
echo '*************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed jq
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo apt install jq -y
fi
