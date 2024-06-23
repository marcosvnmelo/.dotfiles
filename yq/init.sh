#!/usr/bin/bash

echo '*************************************'
echo '*           Installing yq           *'
echo '*************************************'

sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
sudo chmod +x /usr/bin/yq
