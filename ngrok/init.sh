#!/usr/bin/bash

echo '****************************************'
echo '*           Installing Ngrok           *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S --noconfirm --needed ngrok
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc |
    sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null &&
    echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" |
    sudo tee /etc/apt/sources.list.d/ngrok.list &&
    sudo apt update &&
    sudo apt install ngrok
fi
