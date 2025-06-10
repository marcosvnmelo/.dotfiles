#!/usr/bin/bash

echo '*********************************************'
echo '*         Installing Android Studio         *'
echo '*********************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S --noconfirm --needed android-studio
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  # TODO: implement script
  echo 'Not implemented yet'
fi
