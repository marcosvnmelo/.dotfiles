#!/usr/bin/bash

# Open daily project based on preset file
if [ "$1" = "--preset" ]; then
  preset_file=~/projects/open-project.json

  if [ ! -f "$preset_file" ]; then
    echo "Preset file not found"
    exit 1
  fi

  for project in $(jq -r '.projects[] | @base64' "$preset_file"); do
    _jq() {
      echo "$project" | base64 --decode | jq -r "$@"
    }

    session_name=$(_jq '.session_name')
    project_dir=$(_jq '.project_dir' | sed "s|~|$HOME|")

    first_window=$(_jq '.windows[0].name')

    if ! tmux has-session -t=$session_name 2>/dev/null; then
      tmux new -ds $session_name -n $first_window -c $project_dir
    else
      continue
    fi

    for window in $(_jq '.windows[] | @base64'); do
      __jq() {
        echo "$window" | base64 --decode | jq -r "$@"
      }

      window_name=$(__jq '.name')
      window_dir=$(__jq '.dir' | sed "s|~|$HOME|")

      if [ "$window_dir" = "null" ]; then
        window_dir=$project_dir
      fi

      if [ "$window_name" != "$first_window" ]; then
        if [ -z "$window_dir" ]; then
          tmux new-window -t $session_name -n $window_name
        else
          tmux new-window -t $session_name -n $window_name -c $window_dir
        fi
      fi
    done
  done

  first_session=$(jq -r '.[0].session_name' "$preset_file")

  # Attach to the first session
  tmux attach -t $first_session:0

  exit 0
fi

# Manually open a project in a new tmux session
paths_file=~/projects/project-paths.json

if [ ! -f "$paths_file" ]; then
  echo "Paths file not found"
  exit 1
fi

project_paths=$(jq -r '.paths[]' "$paths_file" | sed "s|~|$HOME|")
project_list=$(echo "$project_paths" | while read -r path; do
  find "$path" -mindepth 1 -maxdepth 1 -type d
done)

project_dir=$(echo "$project_list" | fzf --height 40% --reverse --header "Select a project")

if [ -z "$project_dir" ]; then
  exit 0
fi

project_name=$(basename "$project_dir" | tr . _)
tmux_running=$(pgrep tmux)

# If not in tmux, start a new session
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s $project_name -c $project_dir
  exit 0
fi

# If in tmux, create a new session if it doesn't exist
if ! tmux has-session -t=$project_name 2>/dev/null; then
  tmux new-session -ds $project_name -c $project_dir
fi

# Switch to the session
tmux switch-client -t $project_name
