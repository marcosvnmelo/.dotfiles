#!/usr/bin/bash

echo '**************************************'
echo '*         Installing Flatpak         *'
echo '**************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed flatpak
fi

flatpak install -y --or-update flathub com.github.tchx84.Flatseal \
  com.rtosta.zapzap \
  dev.vencord.Vesktop \
  app.zen_browser.zen \
  it.mijorus.gearlever \
  io.beekeeperstudio.Studio \
  io.dbeaver.DBeaverCommunity \
  com.github.unrud.VideoDownloader

# Zen browser
xdg-settings set default-web-browser app.zen_browser.zen.desktop
flatpak override --user --env=MOZ_DISABLE_WAYLAND_PROXY=1 app.zen_browser.zen
