#!/usr/bin/bash

echo '*****************************************'
echo '*           Installing Neovim           *'
echo '*****************************************'

curl -LO 'https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz'

sudo tar -C /opt -xzf nvim-linux64.tar.gz

rm nvim-linux64.tar.gz

sudo ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim

mkdir -p ~/.config/nvim

git clone https://github.com/marcosvnmelo/nvim-config ~/.config/nvim

# Install neovim dependencies

sudo apt install -y gcc ripgrep fd-find fzf build-essential

fish -c "nvm use lts && pnpm i -g neovim tree-sitter tree-sitter-cli"
