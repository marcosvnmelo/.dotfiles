#!/usr/bin/bash

if [[ $INSTALL_OS = 'popos' ]]; then
  echo '**********************************************************'
  echo "*            Ignoring Hyprland on $INSTALL_OS            *"
  echo '**********************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '*********************************************'
echo '*            Installing Hyprland            *'
echo '*********************************************'

# Hyprland packages
yes | sudo pacman -S hyprland qt5-wayland qt6-wayland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk polkit-gnome \
  waybar \
  rofi-wayland \
  sddm qt5-quickcontrols2 qt6-5compat qt6-svg \
  nautilus pavucontrol cliphist gtk-engine-murrine gnome-themes-extra

yes | yay -S swaync \
  hyprshot hyprlock hypridle hyprpicker hyprpaper \
  xdg-desktop-portal-hyprland-git overskride network-manager-applet

sudo systemctl enable sddm.service

# Waybar config
ln -s "$HOME"/.dotfiles/hyprland/waybar "$HOME"/.config/waybar

# Hyprland config
ln -s "$HOME"/.dotfiles/hyprland/hypr "$HOME"/.config/hypr

# Rofi config
ln -s "$HOME"/.dotfiles/hyprland/rofi "$HOME"/.config/rofi

# GTK theme
mkdir -p "$HOME"/.themes
unzip "$HOME"/.dotfiles/hyprland/kanagawa-gtk.zip -d "$HOME"/.themes

# Fonts config
ln -s "$HOME"/.dotfiles/hyprland/fontconfig "$HOME"/.config/fontconfig

# Sddm theme
git clone https://github.com/marcosvnmelo/sddm-kanagawa-dragon-theme ~/sddm-kanagawa-dragon-theme
sudo mkdir -p /usr/share/sddm/themes
sudo cp -r ~/sddm-kanagawa-dragon-theme/kanagawa-dragon /usr/share/sddm/themes
sudo rm -r ~/sddm-kanagawa-dragon-theme

# Sddm config
sudo mkdir /etc/sddm.conf.d
sudo ln -s "$HOME"/.dotfiles/hyprland/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf
