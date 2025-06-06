#!/usr/bin/bash

echo '*************************************'
echo '*         Installing VSCode         *'
echo '*************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S --noconfirm --needed visual-studio-code-bin
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  xdg-open "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

# Run after download
# sudo dpkg -i "code_amd64.deb"
# rm "code_amd64.deb"
fi
