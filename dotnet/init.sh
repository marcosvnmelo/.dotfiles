#!/usr/bin/bash

echo '*******************************************'
echo '*            Installing dotnet            *'
echo '*******************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  sudo pacman -S --noconfirm --needed dotnet-runtime dotnet-sdk aspnet-runtime aspnet-targeting-pack
fi

if [[ $INSTALL_OS = 'debian' ]]; then
  # TODO: implement script
  echo 'Not implemented yet'
fi
