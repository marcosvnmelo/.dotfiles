#!/usr/bin/bash

echo '****************************************'
echo '*         Installing terraform         *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed terraform
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo apt update &&
    sudo apt install -y gnupg software-properties-common

  wget -O- https://apt.releases.hashicorp.com/gpg |
    gpg --dearmor |
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

  gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
    sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt update -y &&
    sudo apt install terraform -y
fi
