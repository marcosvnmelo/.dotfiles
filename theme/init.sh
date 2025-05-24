#!/usr/bin/bash

THEME_NAME="kanagawa-dragon"

echo '******************************************'
echo '*            Installing Theme            *'
echo '******************************************'

echo "Installing $THEME_NAME theme"

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed gtk-engine-murrine # gnome-themes-extra
  yay -S --noconfirm --needed bibata-cursor-git
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  sudo apt install gtk2-engines-murrine -y
fi

# Themes and icons
mkdir ~/.themes
mkdir ~/.icons

mkdir -p /tmp/dotfiles

git clone https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme.git /tmp/dotfiles/kanagawa-gtk-theme

/tmp/dotfiles/kanagawa-gtk-theme/themes/install.sh --tweaks dragon

rm -rf ~/.icons/Kanagawa
mv /tmp/dotfiles/kanagawa-gtk-theme/icons/Kanagawa ~/.icons

rm -rf /tmp/dotfiles

# Cursor
cp -r /usr/share/icons/Bibata-Modern-Classic ~/.icons

# Flatpak overrides
flatpak override --user --filesystem=~/.themes
flatpak override --user --filesystem=~/.icons
flatpak override --user --env=XCURSOR_PATH=~/.icons
