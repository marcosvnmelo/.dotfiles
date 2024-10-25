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
yes | sudo pacman -S hyprland waybar wofi sddm ttf-font-awesome nautilus pavucontrol cliphist gtk-engine-murrine gnome-themes-extra
go install github.com/pdf/cliphist-wofi-img@latest

yes | yay -S hyprpolkitagent-git hyprshot swaync hyprlock hypridle hyprpicker hyprpaper xdg-desktop-portal-hyprland-git

sudo systemctl enable sddm.service

# Waybar config
mkdir -p "$HOME"/.config/waybar
ln -s "$HOME"/.dotfiles/hyprland/waybar.jsonc "$HOME"/.config/waybar/config

# Hyprland config
ln -s "$HOME"/.dotfiles/hyprland/hypr "$HOME"/.config/hypr

# Wofi config
mkdir -p "$HOME"/.config/wofi
ln -s "$HOME"/.dotfiles/hyprland/wofi.conf "$HOME"/.config/wofi/config

# GTK theme
mkdir -p "$HOME"/.themes
unzip "$HOME"/.dotfiles/hyprland/kanagawa-gtk.zip -d "$HOME"/.themes
