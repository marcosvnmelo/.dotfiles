#!/usr/bin/bash

echo '*****************************************'
echo '*           Installing chrome           *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S google-chrome
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  curl -L 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' -o 'chrome.deb'

  sudo apt install --fix-missing ./chrome.deb -y

  rm chrome.deb
fi
