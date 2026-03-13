#!/usr/bin/bash

echo '****************************************'
echo '*            Installing bun            *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed bun
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  curl -fsSL https://bun.sh/install | bash
fi
