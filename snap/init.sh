#!/usr/bin/bash

if [[ $INSTALL_OS != 'debian' ]]; then
  echo '******************************************************'
  echo "*            Ignoring Snap on $INSTALL_OS            *"
  echo '******************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '*****************************************'
echo '*            Installing Snap            *'
echo '*****************************************'

sudo apt install snapd -y
