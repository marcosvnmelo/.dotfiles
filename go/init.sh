#!/usr/bin/bash

echo '*****************************************'
echo '*             Installing go             *'
echo '*****************************************'

file=$(curl -L -s 'https://go.dev/dl' | grep -m 1 '/dl/go.*.linux-amd64' | awk -F "/" '{print $3}' | awk -F '">' '{print $1}')

curl -L "https://go.dev/dl/$file" -o go.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go.tar.gz

rm go.tar.gz
