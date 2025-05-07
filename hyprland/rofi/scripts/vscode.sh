#/bin/bash

if [ -n "$1" ]; then
  project_path=$(echo "$1" | sed "s|~|$HOME|")
  code "$project_path"

  exit 0
fi

history_key="history.recentlyOpenedPathsList"
history_json=$(sqlite3 ~/.config/Code/User/globalStorage/state.vscdb "SELECT value FROM ItemTable WHERE key = '$history_key'")

if [ -z "$history_json" ]; then
  echo "No recently opened files"
  exit 1
fi

echo "$history_json" | jq -r '.entries[].folderUri' | sed "s|file://$HOME|~|"
