!/usr/bin/bash

echo '***************************************'
echo '*           Installing Edge           *'
echo '***************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S --noconfirm --needed microsoft-edge-stable-bin
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  # TODO: implement this
  echo 'Not implemented yet'
fi

# HACK: Fixes the copilot sidebar not showing up
if [[ -d ~/.config/microsoft-edge/Default/ ]]; then
  if [[ ! -f ~/.config/microsoft-edge/Default/HubApps ]]; then
    curl -L 'https://github.com/user-attachments/files/17536771/HubApps.txt' \
      -o ~/.config/microsoft-edge/Default/HubApps
  fi
fi
