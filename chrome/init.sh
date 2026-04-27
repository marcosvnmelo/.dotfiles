#!/usr/bin/bash

echo '*****************************************'
echo '*           Installing Chrome           *'
echo '*****************************************'

INSTALL_MODE='flatpak' # 'bare', 'flatpak'

if [[ $INSTALL_MODE = 'bare' ]]; then

  if [[ $INSTALL_OS = 'arch' ]]; then
    yay -S --noconfirm --needed google-chrome
  fi

  if [[ $INSTALL_OS = 'debian' ]]; then
    flatpak install -y --or-update flathub com.google.Chrome

    mkdir -p /tmp/dotfiles

    curl -L 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' \
      -o /tmp/dotfiles/chrome.deb

    sudo apt install --fix-missing /tmp/dotfiles/chrome.deb -y

    rm -rf /tmp/dotfiles
  fi

fi

if [[ $INSTALL_MODE = 'flatpak' ]]; then
  flatpak install -y --or-update flathub com.google.Chrome

  flatpak override --user \
    --filesystem=~/.local/share/applications \
    --filesystem=~/.local/share/icons com.google.Chrome
fi

# Chrome (pwa)
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons

for file in "$CURRENT_DIR"/chrome-pwa/applications/*; do
  if [[ -f "$file" ]]; then
    ln -sf "$file" ~/.local/share/applications/"$(basename "$file")"
  fi
done

if [[ -d ~/.local/share/icons ]]; then
  rm -rf ~/.local/share/icons/hicolor
fi
ln -sf "$CURRENT_DIR"/chrome-pwa/icons/hicolor ~/.local/share/icons/
