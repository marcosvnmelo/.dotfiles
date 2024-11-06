#!/usr/bin/bash

echo '************************************************'
echo '*            Installing Zen Browser            *'
echo '************************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | yay -S zen-browser-avx2-bin
  xdg-settings set default-web-browser zen-alpha.desktop
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  flatpak install flathub io.github.zen_browser.zen
  xdg-settings set default-web-browser io.github.zen_browser.zen.desktop
fi
