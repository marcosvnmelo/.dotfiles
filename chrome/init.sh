#!/usr/bin/bash

echo '*****************************************'
echo '*           Installing chrome           *'
echo '*****************************************'

curl -L 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' -o 'chrome.deb'

sudo apt install --fix-missing ./chrome.deb -y

rm chrome.deb
