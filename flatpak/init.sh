#!/usr/bin/bash

echo '**************************************'
echo '*         Installing Flatpak         *'
echo '**************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | sudo pacman -S flatpak
fi

flatpak install flathub com.github.tchx84.Flatseal \
  com.rtosta.zapzap \
  dev.vencord.Vesktop \
  io.github.zen_browser.zen \
  it.mijorus.gearlever

xdg-settings set default-web-browser io.github.zen_browser.zen.desktop
