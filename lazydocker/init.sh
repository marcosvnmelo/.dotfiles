#!/usr/bin/bash

echo '*********************************************'
echo '*           Installing Lazydocker           *'
echo '*********************************************'

bash -c "cd /tmp && curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash"

mkdir -p ~/.config/lazydocker
ln -sf ~/.dotfiles/lazydocker/config.yml ~/.config/lazydocker/config.yml
