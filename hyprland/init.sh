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
yes | sudo pacman -S hyprland waybar wofi sddm ttf-font-awesome nautilus

yes | yay -S hyprpolkitagent-git hyprshot swaync

# Hyprland config
mkdir -p "$HOME"/.config/hypr
ln -s "$HOME"/.dotfiles/hyprland/hyprland.conf "$HOME"/.config/hypr/hyprland.conf

# Waybar config
mkdir -p "$HOME"/.config/waybar
ln -s "$HOME"/.dotfiles/hyprland/waybar.jsonc "$HOME"/.config/waybar/config
