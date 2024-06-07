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

sudo apt install -y gcc
sudo apt install -y ripgrep
sudo apt install -y fd-find
sudo apt install -y fzf
sudo apt install -y build-essential

./"$PWD"/nvim/dependencies/lazygit/init.sh

pnpm i -g neovim
pnpm i -g tree-sitter
pnpm i -g tree-sitter-cli
