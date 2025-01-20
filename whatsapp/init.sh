#!/usr/bin/bash

echo '***************************************************'
echo '*           Installing Whatsapp Client            *'
echo '***************************************************'

if [[ $INSTALL_OS = 'arch' ]]; then
  yes | yay -S whatsapp-for-linux
fi

if [[ $INSTALL_OS = 'popos' ]]; then
  # TODO: implement debian based distros
  echo 'Not implemented yet'
fi
