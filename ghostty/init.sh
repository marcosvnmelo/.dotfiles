#!/usr/bin/bash

if [[ $INSTALL_IN_WSL = true ]]; then
  echo '*********************************************************'
  echo "*            Ignoring Ghostty on $INSTALL_OS            *"
  echo '*********************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '**************************************'
echo '*         Installing Ghostty         *'
echo '**************************************'

# Install ghostty

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed ghostty
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  bash -c "curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh | bash"
fi

# Create symbolic link for ghostty configuration file

mkdir -p ~/.config/ghostty

rm ~/.config/ghostty/config
ln -sf ~/.dotfiles/ghostty/config.conf ~/.config/ghostty/config

# Create symbolic link to gnome-terminal redirect to ghostty
if [[ $INSTALL_OS = 'arch' ]]; then
  sudo ln -sf ~/.dotfiles/ghostty/fake-gnome-terminal.sh /usr/bin/gnome-terminal
fi

# Set ghostty as default terminal
# sudo update-alternatives --config x-terminal-emulator
