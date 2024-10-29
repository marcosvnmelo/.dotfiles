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
  waybar blueman \
  rofi-wayland \
  sddm qt5-quickcontrols2 qt6-5compat qt6-svg \
  nautilus python-nautilus file-roller loupe pavucontrol cliphist gtk-engine-murrine gnome-themes-extra wtype

yes | yay -S swaync envycontrol \
  hyprshot hyprlock hypridle hyprpicker hyprpaper \
  network-manager-applet \
  nautilus-open-any-terminal \
  kanagawa-gtk-theme-git kanagawa-icon-theme-git bibata-cursor-git

sudo systemctl enable sddm.service

# Waybar config
ln -s "$HOME"/.dotfiles/hyprland/waybar "$HOME"/.config/waybar

# Hyprland config
ln -s "$HOME"/.dotfiles/hyprland/hypr "$HOME"/.config/hypr

# Rofi config
ln -s "$HOME"/.dotfiles/hyprland/rofi "$HOME"/.config/rofi

# GTK theme
gsettings set org.gnome.desktop.interface gtk-theme Kanagawa-Borderless
gsettings set org.gnome.desktop.interface icon-theme Kanagawa
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic
gsettings set org.gnome.desktop.interface font-name "NotoSans Font 11"
gsettings set org.gnome.desktop.interface document-font-name "NotoSans Font 11"
gsettings set org.gnome.desktop.interface monospace-font-name "NotoSansM Nerd Font Mono 10"

mkdir ~/.themes
mkdir ~/.icons

flatpak override --user --filesystem=~/.themes
flatpak override --user --filesystem=~/.icons

sudo cp -r /usr/share/themes/Kanagawa-Borderless ~/.themes
sudo cp -r /usr/share/icons/Kanagawa ~/.icons
sudo cp -r /usr/share/icons/Bibata-Modern-Classic ~/.icons

mkdir ~/.config/gtk-3.0
touch ~/.config/gtk-3.0/bookmarks

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

# Code flags
sudo ln -s "$HOME"/.dotfiles/hyprland/code-flags.conf "$HOME"/.config/code-flags.conf

# Swaync style
ln -s ~/.dotfiles/hyprland/swaync ~/.config/swaync
