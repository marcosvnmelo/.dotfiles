#!/usr/bin/bash

echo '*********************************************'
echo '*           Installing Lazydocker           *'
echo '*********************************************'

if [[ $INSTALL_OS = 'wsl' ]]; then
  echo '************************************************************'
  echo "*            Ignoring Lazydocker on $INSTALL_OS            *"
  echo '************************************************************'

  return 0 2>/dev/null || exit 0
fi

$DOTFILES_DIR = $PWD
cd $HOME

curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

cd $DOTFILES_DIR

mkdir -p ~/.config/lazydocker
ln -s ~/.dotfiles/lazydocker/config.yml ~/.config/lazydocker/config.yml
