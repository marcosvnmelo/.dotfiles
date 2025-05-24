#!/usr/bin/bash

INSTALL_OS="arch"
INSTALL_IN_WSL=false

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_module() {
  INSTALL_OS="$INSTALL_OS" \
    INSTALL_IN_WSL="$INSTALL_IN_WSL" \
    DOTFILES_DIR="$CURRENT_DIR" \
    CURRENT_DIR="$CURRENT_DIR/$@" \
    $CURRENT_DIR/$@/init.sh
}

if [ $# -eq 0 ]; then
  gen_modules_list() {
    cat "$CURRENT_DIR"/modules.list | sed 's/#.*//g' | xargs echo
  }

  # Execute the init.sh file for each module
  for module in $(gen_modules_list); do
    run_module "$module"
  done
else
  run_module "$1"
fi

fish -c "fish_update_completions"
