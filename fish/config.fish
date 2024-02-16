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
alias dotfiles="cd ~/.dotfiles && ./install.sh"

# bun

set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH "$BUN_INSTALL" $PATH

# Starship

starship init fish | source

# nvm

set --universal nvm_default_version v20.11.0

# go

set -gx PATH $PATH /usr/local/go/bin

# pnpm
set -gx PNPM_HOME "/home/marcos/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
