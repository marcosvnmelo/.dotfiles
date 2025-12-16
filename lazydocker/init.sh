#!/usr/bin/bash

echo '*********************************************'
echo '*           Installing Lazydocker           *'
echo '*********************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed lazydocker
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  bash -c "cd /tmp && curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash"
fi

mkdir -p ~/.config/lazydocker
ln -sf ~/.dotfiles/lazydocker/config.yml ~/.config/lazydocker/config.yml
