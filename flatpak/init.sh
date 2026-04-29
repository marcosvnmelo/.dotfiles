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
  dev.vencord.Vesktop \
  app.zen_browser.zen \
  it.mijorus.gearlever \
  io.beekeeperstudio.Studio \
  md.obsidian.Obsidian \
  org.videolan.VLC \
  io.missioncenter.MissionCenter \
  eu.betterbird.Betterbird \
  io.github.shonebinu.Brief

# com.rtosta.zapzap
# com.warlordsoftwares.formatlab
# com.ulduzsoft.Birdtray
# com.github.tenderowl.frog
# com.github.unrud.VideoDownloader
# com.usebruno.Bruno
# org.guitarix.Guitarix

# Global
flatpak override --user --env=QT_SCALE_FACTOR=1.6

# Zen browser
xdg-settings set default-web-browser app.zen_browser.zen.desktop
flatpak override --user --env=MOZ_DISABLE_WAYLAND_PROXY=1 app.zen_browser.zen

# Obsidian
flatpak override --user --socket=wayland md.obsidian.Obsidian

# Vesktop
flatpak override --user --nosocket=x11 dev.vencord.Vesktop
flatpak override --user --filesystem=xdg-documents:ro dev.vencord.Vesktop

if command -v pnpm >/dev/null 2>&1; then
  pnpm install -g arrpc
else
  echo "Warning: pnpm not found. Skipping arrpc installation."
fi

# Guitarix
flatpak override --user --socket=wayland org.guitarix.Guitarix
flatpak override --user --env=PIPEWIRE_LATENCY=128/44100 org.guitarix.Guitarix

# Thunderbird
# flatpak override --user --socket=wayland org.mozilla.Thunderbird
# flatpak override --user --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.Thunderbird

# Betterbird
flatpak override --user \
  --filesystem=~/.var/app/eu.betterbird.Betterbird \
  --talk-name=org.freedesktop.Notifications \
  com.ulduzsoft.Birdtray

# --nosocket=wayland eu.betterbird.Betterbird
# --env=GDK_DPI_SCALE=1.6 eu.betterbird.Betterbird
flatpak override --user \
  --env=MOZ_DISABLE_WAYLAND_PROXY=1 \
  --env=MOZ_ENABLE_WAYLAND=1 \
  eu.betterbird.Betterbird
