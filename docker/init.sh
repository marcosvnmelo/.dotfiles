#!/usr/bin/bash

echo '*******************************************'
echo '*            Installing docker            *'
echo '*******************************************'

sudo apt install docker.io docker-compose
sudo systemctl enable --now docker docker.socket containerd
sudo usermod -aG docker $USER
