#!/usr/bin/bash

if [[ $INSTALL_IN_WSL = true ]]; then
  echo '*******************************************************'
  echo "*            Ignoring Fcitx on $INSTALL_OS            *"
  echo '*******************************************************'

  return 0 2>/dev/null || exit 0
fi

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
