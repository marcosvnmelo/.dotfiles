#!/usr/bin/bash

echo 'Installing Neovim'

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

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

pnpm i -g neovim
pnpm i -g tree-sitter-cli
