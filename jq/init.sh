#!/usr/bin/bash

echo '*************************************'
echo '*           Installing jq           *'
echo '*************************************'

sudo apt install jq -y

sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
sudo chmod +x /usr/bin/yq
