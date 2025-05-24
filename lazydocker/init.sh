#!/usr/bin/bash

echo '*********************************************'
echo '*           Installing Lazydocker           *'
echo '*********************************************'

if [[ $INSTALL_IN_WSL ]]; then
  echo '************************************************************'
  echo "*            Ignoring Lazydocker on $INSTALL_OS            *"
  echo '************************************************************'

  return 0 2>/dev/null || exit 0
fi

bash -c "curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash"

mkdir -p ~/.config/lazydocker
ln -sf ~/.dotfiles/lazydocker/config.yml ~/.config/lazydocker/config.yml
