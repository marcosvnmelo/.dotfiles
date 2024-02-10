#!/bin/bash

echo 'Installing fish shell'

# Install fish shell

sudo apt-add-repository ppa:fish-shell/release-3 -y

sudo apt update -y && sudo apt upgrade -y

sudo apt install fish -y

sudo chsh -s /usr/bin/fish

# Create symbolic link for fish configuration file

mkdir -p $HOME/.config/fish

ln -s $HOME/.dotfiles/fish/config.fish $HOME/.config/fish/config.fish

# Install fisher

fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Install fish plugins

while IFS= read -r plugin; do
	if [[ $plugin == \#* ]]; then
		continue
	fi
	fish -c "fisher install $plugin"
done <plugins
