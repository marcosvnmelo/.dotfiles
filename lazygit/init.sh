#!/usr/bin/bash

echo '******************************************'
echo '*           Installing Lazygit           *'
echo '******************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed lazygit
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

  mkdir -p /tmp/dotfiles

  curl -Lo /tmp/dotfiles/lazygit.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

  tar xf /tmp/dotfiles/lazygit.tar.gz -C /tmp/dotfiles

  sudo install /tmp/dotfiles/lazygit /usr/local/bin

  rm /tmp/dotfiles/lazygit.tar.gz
  rm -rf /tmp/dotfiles
fi

mkdir -p ~/.config/lazygit
ln -sf ~/.dotfiles/lazygit/config.yml ~/.config/lazygit/config.yml
