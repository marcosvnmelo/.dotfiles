#!/usr/bin/bash

echo '*****************************************'
echo '*           Installing Neovim           *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed neovim
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo snap install nvim --classic
fi

if [[ -d ~/.config/nvim ]]; then
  rm -rf ~/.config/nvim
fi
git submodule update --init -- "$CURRENT_DIR/config"
ln -s "$CURRENT_DIR/config" ~/.config/nvim

# Install neovim dependencies

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed ripgrep fd fzf
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo apt install -y gcc ripgrep fd-find fzf build-essential
fi

fish -c "nvm use lts && \
  pnpm add -g --allow-build=tree-sitter-cli neovim tree-sitter tree-sitter-cli \
  cspell @cspell/dict-pt-br && \
  cspell link add @cspell/dict-pt-br"
