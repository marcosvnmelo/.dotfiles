#!/usr/bin/bash

if [[ $INSTALL_OS != 'arch' ]]; then
  echo '**********************************************************'
  echo "*            Ignoring Hyprland on $INSTALL_OS            *"
  echo '**********************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '*********************************************'
echo '*            Installing Hyprland            *'
echo '*********************************************'

# Hyprland packages
sudo pacman -S --noconfirm --needed hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk polkit-gnome \
  hyprlock hypridle hyprpicker hyprpaper waybar blueman rofi-wayland \
  sddm qt5-quickcontrols2 qt6-5compat qt6-svg qt5-wayland qt6-wayland \
  nautilus python-nautilus file-roller loupe pavucontrol nwg-displays \
  cliphist wtype \
  mpv

yay -S --noconfirm --needed swaync envycontrol \
  hyprshot-git kanata-bin rofi-power-menu rofi-emoji-git rofi-calc-git \
  network-manager-applet indicator-sound-switcher \
  arrpc \
  nautilus-open-any-terminal gnome-keyring

# Waybar config
if [[ -d ~/.config/waybar ]]; then
  rm -rf ~/.config/waybar
fi
ln -s $CURRENT_DIR/waybar ~/.config/waybar

# Hyprland config
if [[ -d ~/.config/hypr ]]; then
  rm -rf ~/.config/hypr
fi
ln -s $CURRENT_DIR/hypr ~/.config/hypr

# Rofi config
if [[ -d ~/.config/rofi ]]; then
  rm -rf ~/.config/rofi
fi
ln -s $CURRENT_DIR/rofi ~/.config/rofi

# GTK settings
gsettings set org.gnome.desktop.interface gtk-theme Kanagawa-Dark-Dragon
gsettings set org.gnome.desktop.interface icon-theme Kanagawa
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic
gsettings set org.gnome.desktop.interface font-name "NotoSans Font 11"
gsettings set org.gnome.desktop.interface document-font-name "NotoSans Font 11"
gsettings set org.gnome.desktop.interface monospace-font-name "NotoSansM Nerd Font Mono 10"

# Bookmarks
mkdir ~/.config/gtk-3.0
touch ~/.config/gtk-3.0/bookmarks

# Fonts config
if [[ -d ~/.config/fontconfig ]]; then
  rm -rf ~/.config/fontconfig
fi
ln -s $CURRENT_DIR/fontconfig ~/.config/fontconfig

# Sddm config
sudo systemctl enable sddm.service

sudo mkdir /etc/sddm.conf.d
sudo ln -sf $CURRENT_DIR/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf

# Sddm theme
mkdir -p /tmp/dotfiles

git clone https://github.com/marcosvnmelo/sddm-kanagawa-dragon-theme /tmp/dotfiles/sddm-theme

sudo mkdir -p /usr/share/sddm/themes
sudo cp -r /tmp/dotfiles/sddm-theme/kanagawa-dragon /usr/share/sddm/themes
sudo rm -r /tmp/dotfiles

# Code flags
sudo ln -sf $CURRENT_DIR/code-flags.conf ~/.config/code-flags.conf

# Swaync style
if [[ -d ~/.config/swaync ]]; then
  rm -rf ~/.config/swaync
fi
ln -s $CURRENT_DIR/swaync ~/.config/swaync

# Kanata config
USER_GROUPS=$(groups $USER)
if [[ $USER_GROUPS != *uinput* ]]; then
  sudo groupadd uinput
  sudo usermod -aG input $USER
  sudo usermod -aG uinput $USER
  echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee -a /etc/udev/rules.d/99-input.rules
  sudo modprobe uinput
fi

# Wireplumber config
if [[ -d ~/.config/wireplumber ]]; then
  rm -rf ~/.config/wireplumber
fi
ln -s $CURRENT_DIR/wireplumber ~/.config

# Custom card symlink
mkdir -p ~/.config/hypr-cards
ln -sf /dev/dri/by-path/pci-0000:00:02.0-card ~/.config/hypr-cards/cardIntel
ls -sf /dev/dri/by-path/pci-0000:01:00.0-card ~/.config/hypr-cards/cardNvidia

# Systemd config
mkdir -p ~/.config/systemd/user

ln -sf $CURRENT_DIR/systemd/kanata.service ~/.config/systemd/user/kanata.service
ln -sf $CURRENT_DIR/systemd/kill-adb-on-logout.service ~/.config/systemd/user/kill-adb-on-logout.service

systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user enable kill-adb-on-logout.service
