#!/usr/bin/bash

echo '*******************************************'
echo '*            Installing docker            *'
echo '*******************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  # Install Docker
  yes | sudo pacman -S docker docker-compose
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl -y
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt update

  # Install Docker
  sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

fi

# Enable docker
sudo groupadd docker
sudo usermod -aG docker $USER

sudo systemctl enable --now docker docker.service containerd.service
