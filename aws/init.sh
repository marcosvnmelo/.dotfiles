#!/usr/bin/bash

echo '******************************************'
echo '*           Installing AWS CLI           *'
echo '******************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed aws-cli-v2
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo snap install aws-cli --classic
fi
