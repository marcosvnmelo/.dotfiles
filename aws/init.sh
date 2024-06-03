#!/usr/bin/bash

echo '******************************************'
echo '*           Installing AWS CLI           *'
echo '******************************************'

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip -d awscli
sudo bash "$PWD"/awscli/aws/install

rm "$PWD"/awscliv2.zip
rm -rf "$PWD"/awscli
