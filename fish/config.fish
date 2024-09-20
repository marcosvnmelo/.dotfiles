if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

# Aliases

alias cat="bat"
alias upd="sudo apt update && sudo apt upgrade"
alias ls="eza"
alias filesize="du -sh * | sort -h"
alias foldersize="du -h -d 1 ."
alias vim="nvim"
alias fd="fdfind"
#alias shutdown="wsl.exe -t Ubuntu-24.04"
#alias win-docker="/mnt/c/Arquivos\ de\ Programas/Docker/Docker/Docker\ Desktop.exe"

# Functions

function dotfiles -d "Run dotfiles modules"
    set -f currentDir $PWD

    cd ~/.dotfiles
    ./install.sh $argv[1]

    cd $currentDir
end

# Starship

starship init fish | source
enable_transience

# nvm

set --universal nvm_default_version v20.17.0

# go

set -gx PATH $PATH /usr/local/go/bin
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# pnpm
set -gx PNPM_HOME "/home/marcos/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Android
set --export ANDROID_HOME "$HOME/Android/sdk"
