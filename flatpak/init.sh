#!/usr/bin/bash

if [[ $INSTALL_IN_WSL = true ]]; then
  echo '*********************************************************'
  echo "*            Ignoring Flatpak on $INSTALL_OS            *"
  echo '*********************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '**************************************'
echo '*         Installing Flatpak         *'
echo '**************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed flatpak
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo apt install -y flatpak gnome-software-plugin-flatpak
fi

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y --or-update flathub com.github.tchx84.Flatseal \
  com.rtosta.zapzap \
  dev.vencord.Vesktop \
  app.zen_browser.zen \
  it.mijorus.gearlever \
  io.beekeeperstudio.Studio \
  io.dbeaver.DBeaverCommunity \
  com.github.unrud.VideoDownloader \
  md.obsidian.Obsidian \
  org.guitarix.Guitarix \
  com.github.tenderowl.frog

# com.warlordsoftwares.formatlab

# Zen browser
xdg-settings set default-web-browser app.zen_browser.zen.desktop
flatpak override --user --env=MOZ_DISABLE_WAYLAND_PROXY=1 app.zen_browser.zen

# Obsidian
flatpak override --user --socket=wayland md.obsidian.Obsidian

# Vesktop
flatpak override --user --nosocket=x11 dev.vencord.Vesktop

# Guitarix
flatpak override --user --socket=wayland org.guitarix.Guitarix
flatpak override --user --env=PIPEWIRE_LATENCY=128/44100 org.guitarix.Guitarix
