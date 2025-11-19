#!/usr/bin/bash

if [[ $INSTALL_IN_WSL = true ]]; then
  echo '********************************************************'
  echo "*            Ignoring Docker on $INSTALL_OS            *"
  echo '********************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '*******************************************'
echo '*            Installing Docker            *'
echo '*******************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  # Install Docker
  sudo pacman -S --noconfirm --needed docker docker-compose docker-buildx cni-plugins
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  if [[ -z $(which docker) ]]; then
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
  fi

  # Install Docker
  sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

fi

USER_GROUPS=$(groups $USER)

if [[ $USER_GROUPS != *docker* ]]; then
  # Enable docker
  sudo groupadd docker
  sudo usermod -aG docker $USER
fi

sudo systemctl enable --now docker docker.service containerd.service
