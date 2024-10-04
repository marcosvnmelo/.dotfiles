#!/usr/bin/bash

echo '******************************************'
echo '*           Installing Lazygit           *'
echo '******************************************'

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
mkdir tmp
tar xf lazygit.tar.gz -C tmp/
sudo install tmp/lazygit /usr/local/bin
rm lazygit.tar.gz
rm -r tmp

mkdir -p "$HOME"/.config/lazygit
ln -s "$HOME"/.dotfiles/lazygit/config.yml "$HOME"/.config/lazygit/config.yml
