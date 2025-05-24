#!/usr/bin/bash

echo '*****************************************'
echo '*         Installing fish shell         *'
echo '*****************************************'

# Install fish shell

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed fish zoxide
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo apt-add-repository ppa:fish-shell/release-3 -y

  sudo apt update -y && sudo apt upgrade -y

  sudo apt install fish -y

  fish -c "curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh"
fi

if [[ $INSTALL_IN_WSL = true ]]; then
  sudo chsh -s /usr/bin/fish "$USER"
fi

# Create symbolic link for fish configuration file

mkdir -p ~/.config/fish

ln -sf ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish

# Install starship prompt

if [[ -z $(which starship) ]]; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

ln -sf ~/.dotfiles/fish/starship.toml ~/.config/starship.toml

# Install fisher

fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Install fish plugins

gen_plugins_list() {
  cat "$CURRENT_DIR"/plugins.list | sed 's/#.*//g' | xargs echo
}

for plugin in $(gen_plugins_list); do
  fish -c "fisher install $plugin"
done

fish -c "nvm install lts && \
  npm install -g fish-lsp && \
  fish-lsp complete > ~/.config/fish/completions/fish-lsp.fish"

# Install completions

get_completions_list() {
  ls "$CURRENT_DIR"/completions | xargs echo
}

for completion in $(get_completions_list); do
  ln -sf ~/.dotfiles/fish/completions/$completion ~/.config/fish/completions/$completion
done
