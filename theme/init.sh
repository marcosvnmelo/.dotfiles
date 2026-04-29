#!/usr/bin/bash

if [[ $INSTALL_IN_WSL = true ]]; then
  echo '*******************************************************'
  echo "*            Ignoring Theme on $INSTALL_OS            *"
  echo '*******************************************************'

  return 0 2>/dev/null || exit 0
fi

THEME_NAME="kanagawa-dragon"

echo '******************************************'
echo '*            Installing Theme            *'
echo '******************************************'

echo "Installing $THEME_NAME theme"

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed gtk-engine-murrine # gnome-themes-extra
  yay -S --noconfirm --needed bibata-cursor-git
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo apt install gtk2-engines-murrine -y
fi

# Themes and icons
mkdir ~/.themes
mkdir ~/.icons

mkdir -p "$INSTALL_TEMP_DIR"

git clone https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme.git "$INSTALL_TEMP_DIR"/kanagawa-gtk-theme

"$INSTALL_TEMP_DIR"/kanagawa-gtk-theme/themes/install.sh --tweaks dragon

rm -rf ~/.icons/Kanagawa
mv "$INSTALL_TEMP_DIR"/kanagawa-gtk-theme/icons/Kanagawa ~/.icons

rm -rf "$INSTALL_TEMP_DIR"

# Cursor
cp -r /usr/share/icons/Bibata-Modern-Classic ~/.icons

# Flatpak overrides
flatpak override --user --filesystem=~/.themes
flatpak override --user --filesystem=~/.icons
flatpak override --user --env=XCURSOR_PATH=~/.icons
