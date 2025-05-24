#!/usr/bin/bash

echo '****************************************'
echo '*           Installing Fonts           *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed ttf-firacode-nerd \
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
    ttf-nerd-fonts-symbols-mono
  yay -S --noconfirm --needed inter-font
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  FONT_VERSION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep -Po '"tag_name": "v\K[^"]*')

  mkdir -p /tmp/dotfiles
  mkdir -p ~/.local/share/fonts

  curl -Lo /tmp/dotfiles/fira_code.zip \
    "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

  unzip /tmp/dotfiles/fira_code.zip -d /tmp/dotfiles

  mv /tmp/dotfiles/*.ttf ~/.local/share/fonts

  rm -rf /tmp/dotfiles
fi
