#!/usr/bin/bash

echo '************************************************'
echo '*            Installing Zen Browser            *'
echo '************************************************'

flatpak install flathub io.github.zen_browser.zen
xdg-settings set default-web-browser io.github.zen_browser.zen.desktop
