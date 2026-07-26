#!/usr/bin/bash

echo '*************************************'
echo '*           Installing yq           *'
echo '*************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed go-yq
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
  sudo chmod +x /usr/bin/yq
fi
