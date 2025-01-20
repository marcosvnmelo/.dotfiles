#!/usr/bin/bash

echo '**************************************'
echo '*         Installing Flatpak         *'
echo '**************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S flatpak
fi

flatpak install flathub com.github.tchx84.Flatseal \
  dev.vencord.Vesktop \
  app.github.zen_browser.zen \
  it.mijorus.gearlever

xdg-settings set default-web-browser app.github.zen_browser.zen.desktop
