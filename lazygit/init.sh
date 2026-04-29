#!/usr/bin/bash

echo '******************************************'
echo '*           Installing Lazygit           *'
echo '******************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed lazygit
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

  mkdir -p "$INSTALL_TEMP_DIR"

  curl -Lo "$INSTALL_TEMP_DIR"/lazygit.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

  tar xf "$INSTALL_TEMP_DIR"/lazygit.tar.gz -C "$INSTALL_TEMP_DIR"

  sudo install "$INSTALL_TEMP_DIR"/lazygit /usr/local/bin

  rm "$INSTALL_TEMP_DIR"/lazygit.tar.gz
  rm -rf "$INSTALL_TEMP_DIR"
fi

mkdir -p ~/.config/lazygit
ln -sf "$CURRENT_DIR"/config.yml ~/.config/lazygit/config.yml
