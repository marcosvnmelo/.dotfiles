#!/usr/bin/bash

declare INSTALL_OS="arch" # arch | debian
declare INSTALL_IN_WSL=false
declare INSTALL_TEMP_DIR="/tmp/dotfiles"

declare CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function run_module() {
  local module_dir="$CURRENT_DIR/$1"

  INSTALL_OS="$INSTALL_OS" \
    INSTALL_IN_WSL="$INSTALL_IN_WSL" \
    INSTALL_TEMP_DIR="$INSTALL_TEMP_DIR" \
    DOTFILES_DIR="$CURRENT_DIR" \
    CURRENT_DIR="$module_dir" \
    $module_dir/init.sh
}

function gen_modules_list() {
  cat "$CURRENT_DIR"/modules.list | sed 's/#.*//g' | xargs echo
}

# Check how many arguments were passed
if [ $# -eq 0 ]; then
  # Execute the init.sh file for each module
  for module in $(gen_modules_list); do
    run_module "$module"
  done
elif [ $# -eq 1 ]; then
  run_module "$1"
else
  echo "Usage: $0 [module_name]"
  exit 1
fi

fish -c "fish_update_completions"
