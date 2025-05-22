#!/usr/bin/bash

echo '*****************************************'
echo '*         Installing fish shell         *'
echo '*****************************************'

# Install fish shell

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed fish zoxide
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  sudo apt-add-repository ppa:fish-shell/release-3 -y

  sudo apt update -y && sudo apt upgrade -y

  sudo apt install fish -y
fi

if [[ $INSTALL_OS = 'wsl' ]]; then
  sudo chsh -s /usr/bin/fish "$USER"
fi

# Create symbolic link for fish configuration file

mkdir -p ~/.config/fish

ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish

# Install starship prompt

curl -sS https://starship.rs/install.sh | sh -s -- -y

ln -s ~/.dotfiles/fish/starship.toml ~/.config/starship.toml

# Install fisher

fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Install fish plugins

while read -r plugin <&4; do
  if [[ $plugin =~ \#.* ]]; then
    continue
  fi

  fish -c "fisher install $plugin"
done 4<"$PWD"/fish/plugins

fish -c "nvm install lts && \
  npm install -g fish-lsp && \
  fish-lsp complete > ~/.config/fish/completions/fish-lsp.fish"

# Install Zoxide

if [[ $INSTALL_OS = 'popos' ]]; then
  fish -c "curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh"
fi
