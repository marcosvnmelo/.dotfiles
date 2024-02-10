#!/usr/bin/bash

echo 'Installing AWS CLI'

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip -d awscli
sudo ./awscli/install

rm awscliv2.zip
rm -rf awscli
