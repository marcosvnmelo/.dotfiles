#!/usr/bin/bash

echo '*****************************************'
echo '*           Installing Neovim           *'
echo '*****************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed neovim
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  curl -LO 'https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz'

  sudo tar -C /opt -xzf nvim-linux64.tar.gz

  rm nvim-linux64.tar.gz

  sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/bin/nvim
fi

if [[ -d ~/.config/nvim ]]; then
  rm -rf ~/.config/nvim
fi
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
