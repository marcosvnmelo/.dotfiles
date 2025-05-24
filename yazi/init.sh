#!/usr/bin/bash

echo '***************************************'
echo '*           Installing Yazi           *'
echo '***************************************'

IS_FIRST_INSTALL=true

if [[ -n $(which yazi) ]]; then
  IS_FIRST_INSTALL=false
fi

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed yazi ffmpegthumbnailer ffmpeg p7zip jq poppler imagemagick
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  # TODO: implement script
  echo 'Not implemented yet'
  return 0 2>/dev/null || exit 0
fi

# Create config directory
mkdir -p ~/.config/yazi/plugins/
ln -sf ~/.dotfiles/yazi/keymap.toml ~/.config/yazi/keymap.toml
ln -sf ~/.dotfiles/yazi/theme.toml ~/.config/yazi/theme.toml
ln -sf ~/.dotfiles/yazi/init.lua ~/.config/yazi/init.lua

if [[ $IS_FIRST_INSTALL = true ]]; then
  # Install plugins
  gen_plugins_list() {
    cat "$CURRENT_DIR"/plugins.list | sed 's/#.*//g' | xargs echo
  }

  for plugin in $(gen_plugins_list); do
    ya pack -a $plugin
  done
else
  # Update plugins
  ya pack -u
fi
