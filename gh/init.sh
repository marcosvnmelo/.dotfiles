#!/usr/bin/bash

echo '*****************************************'
echo '*         Installing GitHub CLI         *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S github-cli
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
    sudo apt update &&
    sudo apt install gh -y
fi

# Install github cli extensions
#
# fish -c "gh extension install https://github.com/nektos/gh-act"
