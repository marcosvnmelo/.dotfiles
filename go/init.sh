#!/usr/bin/bash

echo '*****************************************'
echo '*             Installing Go             *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed go
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  file=$(curl -L -s 'https://go.dev/dl' | grep -m 1 '/dl/go.*.linux-amd64' | awk -F "/" '{print $3}' | awk -F '">' '{print $1}')

  mkdir -p /tmp/dotfiles

  curl -L "https://go.dev/dl/$file" -o /tmp/dotfiles/go.tar.gz
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf /tmp/dotfiles/go.tar.gz

  rm -rf /tmp/dotfiles
fi
