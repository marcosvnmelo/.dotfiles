#!/bin/bash

history_key="history.recentlyOpenedPathsList"
history_json=$(sqlite3 ~/.config/Code/User/globalStorage/state.vscdb "SELECT value FROM ItemTable WHERE key = '$history_key'")

if [ -n "$1" ]; then
  project_index=$(echo $1 | sed 's/^\([0-9]\+\)\..*/\1/' | jq -r '. | tonumber - 1')

  project_path=$(echo "$history_json" | jq -r ".entries[$project_index].folderUri")

  code --folder-uri "$project_path"

  exit
fi

if [ -z "$history_json" ]; then
  echo "No recently opened files"
  exit 1
fi

echo "$history_json" | jq -r '.entries
  | to_entries[]
  | (.key + 1 | tostring) + ". " + (if .value.label then .value.label elif .value.folderUri then .value.folderUri else .value.fileUri end)' |
  sed "s|file://$HOME|~|"
