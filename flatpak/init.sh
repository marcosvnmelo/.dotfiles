#!/usr/bin/bash

if [[ $INSTALL_OS = 'popos' ]]; then
  echo '*********************************************************'
  echo "*            Ignoring Flatpak on $INSTALL_OS            *"
  echo '*********************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '**************************************'
echo '*         Installing Flatpak         *'
echo '**************************************'

yes | sudo pacman -S flatpak
