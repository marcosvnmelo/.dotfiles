#!/usr/bin/bash

echo '*****************************************'
echo '*            Installing btop            *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed btop
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo snap install btop
fi

ln -sf "$CURRENT_DIR"/btop.conf ~/.config/btop/btop.conf
