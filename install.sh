#!/usr/bin/bash

INSTALL_OS="arch"

if [ $# -eq 0 ]; then

  # Execute the init.sh file for each module
  while read -r module <&3; do
    if [[ $module =~ \#.* ]]; then
      continue
    fi

    bash -c "env INSTALL_OS=$INSTALL_OS ./$module/init.sh"
  done 3<"$PWD"/modules
else
  bash -c "env INSTALL_OS=$INSTALL_OS ./$1/init.sh"
fi

fish -c "fish_update_completions"
