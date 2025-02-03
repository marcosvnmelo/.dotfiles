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
  app.zen_browser.zen \
  it.mijorus.gearlever \
  io.beekeeperstudio.Studio \
  io.dbeaver.DBeaverCommunity

xdg-settings set default-web-browser app.zen_browser.zen.desktop
