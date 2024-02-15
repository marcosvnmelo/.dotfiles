#!/usr/bin/bash

echo 'Installing chrome'

curl -L 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' -o 'chrome.deb'

sudo apt install --fix-missing ./chrome.deb

rm chrome.deb
