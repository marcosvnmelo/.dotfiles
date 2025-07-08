if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

## Aliases ##

function cat -d "Use bat instead of cat"
    bat $argv
end

function ls -d "Use eza with icons and colors"
    eza --icons=always --color=always $argv
end

function filesize -d "Show file sizes sorted by size"
    du -sh * | sort -h
end

function foldersize -d "Show folder size with depth 1"
    du -h -d 1 .
end

function vim -d "Use neovim instead of vim"
    nvim $argv
end

function neofetch -d "Use fastfetch instead of neofetch"
    fastfetch $argv
end

function upd -d "Update all packages"
    # Arch Linux
    flatpak update && yay -Syu
    # Debian
    # sudo apt update && sudo apt upgrade
end

# Debian
# alias fd="fdfind"

# WSL
# alias shutdown="wsl.exe -t Ubuntu-24.04"
# alias win-docker="/mnt/c/Arquivos\ de\ Programas/Docker/Docker/Docker\ Desktop.exe"

## Functions ##

function dotfiles -d "Run dotfiles modules"
    ~/.dotfiles/install.sh $argv[1]
end

function nv-run -d "Run with nvidia"
    DRI_PRIME=pci-0000_01_00_0 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia $argv
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

## Starship ##

starship init fish | source
enable_transience

## nvm ##

set --global nvm_default_version v22.17.0

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
set -gx ANDROID_HOME "$HOME/Android/Sdk"
set -gx ANDROID_NDK_HOME "$ANDROID_HOME/ndk"
set -gx PATH $PATH "$ANDROID_HOME/platform-tools"
set -gx PATH $PATH "$ANDROID_HOME/emulator"
set -gx PATH $PATH "$HOME/flutter/bin"

## Local bin ##
set -gx PATH $PATH ~/.local/bin

## FZF plugin config ##
set fzf_diff_highlighter delta --paging=never --width=20
set fzf_preview_dir_cmd eza --all --color=always --icons=always
fzf_configure_bindings --directory=ctrl-t --git_status=ctrl-g

## Custom key bindings ##
bind ctrl-o '~/.dotfiles/tmux/open-project.sh'
bind ctrl-shift-o '~/.dotfiles/tmux/open-project.sh --preset'
bind ctrl-shift-b btop
