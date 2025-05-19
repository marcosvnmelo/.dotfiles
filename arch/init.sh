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

sudo pacman -Syy --noconfirm
sudo pacman -S --noconfirm --needed linux-headers
sudo pacman -S --noconfirm --needed nvidia-dkms nvidia-utils egl-wayland
sudo pacman -S --noconfirm --needed intel-media-driver vulkan-intel libva-intel-driver
sudo pacman -S --noconfirm --needed git base-devel
sudo pacman -S --noconfirm --needed brightnessctl neofetch bluez bluez-utils fuse sof-firmware

bash -c "git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si"

sudo systemctl enable bluetooth
