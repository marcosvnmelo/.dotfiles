#!/usr/bin/bash

echo '************************************'
echo '*         Installing Fcitx         *'
echo '************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S fcitx5-im fcitx5-mozc --noconfirm --needed
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  # TODO: implement script
  echo 'Not implemented yet'
fi
