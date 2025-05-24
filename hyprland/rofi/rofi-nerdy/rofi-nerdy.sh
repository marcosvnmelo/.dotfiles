#!/bin/bash

if [ -n "$1" ]; then
  first_char=$(echo "$1" | awk '{print substr($0,1,1)}')
  wl-copy "$first_char"
  exit 0
fi

emoji_path=~/.config/rofi/rofi-nerdy/emojis.list
cat $emoji_path
