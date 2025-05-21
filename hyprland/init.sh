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
sudo pacman -S --noconfirm --needed hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk polkit-gnome \
  hyprlock hypridle hyprpicker hyprpaper waybar blueman rofi-wayland \
  sddm qt5-quickcontrols2 qt6-5compat qt6-svg qt5-wayland qt6-wayland \
  gtk-engine-murrine gnome-themes-extra \
  nautilus python-nautilus file-roller loupe pavucontrol nwg-displays \
  cliphist wtype \
  mpv

yay -S --noconfirm --needed swaync envycontrol \
  hyprshot-git kanata-bin rofi-power-menu rofi-emoji-git rofi-calc-git \
  network-manager-applet indicator-sound-switcher \
  arrpc \
  nautilus-open-any-terminal gnome-keyring \
  kanagawa-gtk-theme-git kanagawa-icon-theme-git bibata-cursor-git

sudo systemctl enable sddm.service

# Waybar config
ln -s "$HOME"/.dotfiles/hyprland/waybar "$HOME"/.config/waybar

# Hyprland config
ln -s "$HOME"/.dotfiles/hyprland/hypr "$HOME"/.config/hypr

# Rofi config
ln -s "$HOME"/.dotfiles/hyprland/rofi "$HOME"/.config/rofi

# GTK theme
gsettings set org.gnome.desktop.interface gtk-theme Kanagawa-Dark-Dragon
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
flatpak override --user --env=XCURSOR_PATH=~/.icons

cp -r /usr/share/themes/Kanagawa-Dark-Dragon ~/.themes
cp -r /usr/share/icons/Kanagawa ~/.icons
cp -r /usr/share/icons/Bibata-Modern-Classic ~/.icons

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

# Kanata config
sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee -a /etc/udev/rules.d/99-input.rules
sudo modprobe uinput

# Wireplumber config
ln -s ~/.dotfiles/hyprland/wireplumber ~/.config

# Systemd config
mkdir -p ~/.config/systemd/user

ln -s ~/.dotfiles/hyprland/systemd/kanata.service ~/.config/systemd/user/kanata.service
ln -s ~/.dotfiles/hyprland/systemd/kill-adb-on-logout.service ~/.config/systemd/user/kill-adb-on-logout.service

systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user enable kill-adb-on-logout.service
