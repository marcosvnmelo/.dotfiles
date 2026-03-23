#!/usr/bin/bash

if [[ $INSTALL_OS != 'arch' ]]; then
  echo '******************************************************'
  echo "*            Ignoring Niri on $INSTALL_OS            *"
  echo '******************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '*****************************************'
echo '*            Installing Niri            *'
echo '*****************************************'

GREETER=greetd # greetd | sddm

# NOTE: Niri packages
yay -S --noconfirm --needed \
  niri xwayland-satellite \
  xdg-desktop-portal-gnome xdg-desktop-portal

# NOTE: Niri config
if [[ -d ~/.config/niri ]]; then
  rm -rf ~/.config/niri
fi
ln -s $CURRENT_DIR/niri ~/.config/niri
