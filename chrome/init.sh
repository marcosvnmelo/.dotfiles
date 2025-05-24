#!/usr/bin/bash

echo '*****************************************'
echo '*           Installing Chrome           *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S --noconfirm --needed google-chrome
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  mkdir -p /tmp/dotfiles

  curl -L 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' \
    -o /tmp/dotfiles/chrome.deb

  sudo apt install --fix-missing /tmp/dotfiles/chrome.deb -y

  rm -rf /tmp/dotfiles
fi
