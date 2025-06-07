#!/bin/bash

echo '***************************************'
echo '*         Installing Obsidian         *'
echo '***************************************'

flatpak install -y --or-update flathub md.obsidian.Obsidian

flatpak override --user --socket=wayland md.obsidian.Obsidian
