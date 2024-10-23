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
yes | sudo pacman -S hyprland waybar wofi sddm ttf-font-awesome nautilus pavucontrol cliphist
go install github.com/pdf/cliphist-wofi-img@latest

yes | yay -S hyprpolkitagent-git hyprshot swaync hyprlock hypridle hyprpicker hyprpaper xdg-desktop-portal-hyprland-git

sudo systemctl enable sddm.service

# Waybar config
mkdir -p "$HOME"/.config/waybar
ln -s "$HOME"/.dotfiles/hyprland/waybar.jsonc "$HOME"/.config/waybar/config

# Hyprland config
mkdir -p "$HOME"/.config/hypr
ln -s "$HOME"/.dotfiles/hyprland/hyprland.conf "$HOME"/.config/hypr/hyprland.conf

# Hyprlock config
ln -s "$HOME"/.dotfiles/hyprland/hyprlock.conf "$HOME"/.config/hypr/hyprlock.conf

# Hypridle config
ln -s "$HOME"/.dotfiles/hyprland/hypridle.conf "$HOME"/.config/hypr/hypridle.conf

# Hyprpaper config
ln -s "$HOME"/.dotfiles/hyprland/hyprpaper.conf "$HOME"/.config/hypr/hyprpaper.conf

# Wofi config
mkdir -p "$HOME"/.config/wofi
ln -s "$HOME"/.dotfiles/hyprland/wofi.conf "$HOME"/.config/wofi/config
