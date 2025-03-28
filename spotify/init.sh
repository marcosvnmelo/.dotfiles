#!/usr/bin/bash

echo '**************************************************'
echo '*           Installing Spotify Client            *'
echo '**************************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | yay -S spotify-launcher
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  # TODO: implement debian based distros
  echo 'Not implemented yet'
fi

ln -s ~/.dotfiles/spotify/spotify-launcher.conf ~/.config/spotify-launcher.conf

# INFO: run this command after the first initialization
# bash <(curl -sSL https://spotx-official.github.io/run.sh)
