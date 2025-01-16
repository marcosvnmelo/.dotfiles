#!/usr/bin/bash

echo '*********************************************'
echo '*           Installing Lazydocker           *'
echo '*********************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | yay -S lazydocker
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  # TODO: implement debian based distros
  echo 'Not implemented yet'
fi

mkdir -p ~/.config/lazydocker
ln -s ~/.dotfiles/lazydocker/config.yml ~/.config/lazydocker/config.yml
