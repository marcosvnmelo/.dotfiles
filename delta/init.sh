#!/usr/bin/bash

echo '************************************'
echo '*         Installing Delta         *'
echo '************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed git-delta
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
  DEB_FILE="git-delta_${DELTA_VERSION}_amd64.deb"

  mkdir -p /tmp/dotfiles

  curl -Lo \
    "/tmp/dotfiles/${DEB_FILE}" \
    "https://github.com/dandavison/delta/releases/latest/download/${DEB_FILE}"

  sudo dpkg -i "/tmp/dotfiles/${DEB_FILE}"

  rm -rf /tmp/dotfiles
fi
