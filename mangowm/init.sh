#!/usr/bin/bash

if [[ $INSTALL_OS != 'arch' ]]; then
  echo '*********************************************************'
  echo "*            Ignoring MangoWM on $INSTALL_OS            *"
  echo '*********************************************************'

  return 0 2>/dev/null || exit 0
fi

echo '********************************************'
echo '*            Installing MangoWM            *'
echo '********************************************'

# NOTE: MangoWM packages
yay -S --noconfirm --needed \
  mangowm-git \
  grim slurp wl-clipboard tesseract tesseract-data-eng imagemagick zbar curl translate-shell wf-recorder ffmpeg \
  gifski

# NOTE: MangoWM config
if [[ -d ~/.config/mango ]]; then
  rm -rf ~/.config/mango
fi
ln -s $CURRENT_DIR/mango ~/.config/mango
