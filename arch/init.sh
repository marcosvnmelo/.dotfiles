#!/usr/bin/bash

if [[ $INSTALL_OS = 'popos' ]]; then
  echo '**************************************************************'
  echo "*            Ignoring Arch minimal on $INSTALL_OS            *"
  echo '**************************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '*************************************************'
echo '*            Installing Arch minimal            *'
echo '*************************************************'

sudo pacman -Syy
yes | sudo pacman -S linx-headers
yes | sudo pacman -S dkms nvidia-dkms nvidia-utils egl-wayland brightnessctl neofetch
yes | sudo pacman -S intel-media-driver vulkan-intel libva-intel-driver
yes | sudo pacman -S --needed git base-devel

bash -c "git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si"
