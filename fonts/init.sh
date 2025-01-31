#!/usr/bin/bash

echo '****************************************'
echo '*           Installing Fonts           *'
echo '****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S ttf-firacode-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-nerd-fonts-symbols-mono
  yes | yay -S inter-font
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  FONT_VERSION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo fira_code.zip "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

  mkdir tmp
  unzip fira_code.zip -d tmp

  mkdir -p "$HOME"/.local/share/fonts
  mv tmp/*.ttf "$HOME"/.local/share/fonts

  rm fira_code.zip
  rm -r tmp
fi
