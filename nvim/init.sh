#!/usr/bin/bash

echo '*****************************************'
echo '*           Installing Neovim           *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S neovim
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  curl -LO 'https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz'

  sudo tar -C /opt -xzf nvim-linux64.tar.gz

  rm nvim-linux64.tar.gz

  sudo ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim
fi

mkdir -p ~/.config/nvim

git clone https://github.com/marcosvnmelo/nvim-config ~/.config/nvim

# Install neovim dependencies

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S ripgrep fd fzf
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  sudo apt install -y gcc ripgrep fd-find fzf build-essential
fi

fish -c "nvm use lts && pnpm i -g neovim tree-sitter tree-sitter-cli"
