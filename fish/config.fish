if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

## Aliases ##

alias cat="bat"
alias ls="eza --icons=always"
alias filesize="du -sh * | sort -h"
alias foldersize="du -h -d 1 ."
alias vim="nvim"
alias fd="fdfind"

# Arch Linux
alias upd="sudo pacman -Syy && sudo pacman -Su"

# Pop!_OS, WSL
# alias upd="sudo apt update && sudo apt upgrade"

# WSL
# alias shutdown="wsl.exe -t Ubuntu-24.04"
# alias win-docker="/mnt/c/Arquivos\ de\ Programas/Docker/Docker/Docker\ Desktop.exe"

## Functions ##

function dotfiles -d "Run dotfiles modules"
    set -f currentDir $PWD

    cd ~/.dotfiles
    ./install.sh $argv[1]

    cd $currentDir
end

function nv-run -d "Run with nvidia"
    DRI_PRIME=pci-0000_01_00_0 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia $argv
end

## Starship ##

starship init fish | source
enable_transience

## nvm ##

set --universal nvm_default_version v20.18.0

## go ##

set -gx PATH $PATH /usr/local/go/bin
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# pnpm
set -gx PNPM_HOME "/home/marcos/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

## bun ##
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

## Android ##
set -gx ANDROID_HOME "$HOME/Android/sdk"
set -gx PATH $PATH "$ANDROID_HOME/platform-tools"
set -gx PATH $PATH "$ANDROID_HOME/emulator"
set -gx PATH $PATH "$HOME/flutter/bin"
