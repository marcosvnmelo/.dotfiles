#!/usr/bin/bash

if [[ $INSTALL_IN_WSL = true ]]; then
  echo '********************************************************'
  echo "*            Ignoring VSCode on $INSTALL_OS            *"
  echo '********************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '*************************************'
echo '*         Installing VSCode         *'
echo '*************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S --noconfirm --needed visual-studio-code-bin
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  if [[ -z $(which code) ]]; then
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
    rm -f packages.microsoft.gpg
  fi

  sudo apt install -y apt-transport-https
  sudo apt update -y
  sudo apt install -y code
fi
