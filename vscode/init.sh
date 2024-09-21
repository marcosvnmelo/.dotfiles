#!/usr/bin/bash

echo '*************************************'
echo '*         Installing VSCode         *'
echo '*************************************'

curl -Lo "code_amd64.deb" "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i "code_amd64.deb"
rm "code_amd64.deb"
