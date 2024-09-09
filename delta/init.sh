#!/usr/bin/bash

echo '************************************'
echo '*         Installing Delta         *'
echo '************************************'

DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -Lo "git-delta_${DELTA_VERSION}_amd64.deb" "https://github.com/dandavison/delta/releases/latest/download/git-delta_${DELTA_VERSION}_amd64.deb"
sudo dpkg -i "git-delta_${DELTA_VERSION}_amd64.deb"
rm "git-delta_${DELTA_VERSION}_amd64.deb"
