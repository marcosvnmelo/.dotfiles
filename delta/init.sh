#!/usr/bin/bash

echo '************************************'
echo '*         Installing Delta         *'
echo '************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed git-delta
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
  DEB_FILE="git-delta_${DELTA_VERSION}_amd64.deb"

  mkdir -p "$INSTALL_TEMP_DIR"

  curl -Lo \
    "$INSTALL_TEMP_DIR/${DEB_FILE}" \
    "https://github.com/dandavison/delta/releases/latest/download/${DEB_FILE}"

  sudo dpkg -i "$INSTALL_TEMP_DIR/${DEB_FILE}"

  rm -rf "$INSTALL_TEMP_DIR"
fi
