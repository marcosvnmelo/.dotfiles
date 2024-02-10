if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

# Aliases

alias cat="/usr/local/bat/bat"
alias upd="sudo apt update && sudo apt upgrade"
alias ls="exa"
alias filesize="du -sh * | sort -h"
alias foldersize="du -h -d 1 ."
alias vim="nvim"
alias fd="fdfind"

# pnpm

set -gx PNPM_HOME "/home/marcos/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# bun

set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH "$BUN_INSTALL" $PATH

# Starship

starship init fish | source

# nvm

set --universal nvm_default_version v20.11.0
