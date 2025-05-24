#!/usr/bin/bash

if [[ $INSTALL_OS = 'debian' ]]; then
  echo '******************************************************'
  echo "*            Ignoring Rust on $INSTALL_OS            *"
  echo '******************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '***********************************'
echo '*         Installing Rust         *'
echo '***********************************'

# Install Rustup

sudo pacman -S --noconfirm --needed rustup

# Install Rust
rustup default stable
