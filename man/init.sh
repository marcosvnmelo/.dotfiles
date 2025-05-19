#!/usr/bin/bash

if [[ $INSTALL_OS = 'popos' ]]; then
  echo '*****************************************************'
  echo "*            Ignoring Man on $INSTALL_OS            *"
  echo '*****************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '****************************************'
echo '*            Installing Man            *'
echo '****************************************'

sudo pacman -S --noconfirm --needed man-db
