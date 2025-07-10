#!/usr/bin/bash

echo '*********************************************'
echo '*         Installing Android Studio         *'
echo '*********************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yay -S --noconfirm --needed android-studio jdk17-temurin
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  sudo snap install android-studio --classic
fi
