#!/usr/bin/bash

# Open daily project based on preset file
if [ "$1" = "--preset" ]; then
  preset_file=~/projects/open-project.json

  if [ ! -f "$preset_file" ]; then
    echo "Preset file not found"
    exit 1
  fi

  # Get workflow names and let user select with fzf
  workflow_count=$(jq -r '.workflows | length' "$preset_file")
  
  if [ "$workflow_count" -eq 0 ]; then
    echo "No workflows found in preset file"
    exit 1
  fi
  
  if [ "$workflow_count" -eq 1 ]; then
    # If only one workflow, use it directly
    workflow_index=0
  else
    # Build a list of workflows with their names and project counts for display
    workflow_list=$(jq -r '.workflows | to_entries | .[] | "\(.key):\(.value.name) (\(.value.projects | length) project(s))"' "$preset_file")
    
    selected_workflow=$(echo "$workflow_list" | fzf --height 40% --reverse --header "Select a workflow")
    
    if [ -z "$selected_workflow" ]; then
      exit 0
    fi
    
    # Extract the workflow index from the selection
    workflow_index=$(echo "$selected_workflow" | cut -d: -f1)
  fi

  # Get projects from the specified workflow
  for project in $(jq -r ".workflows[$workflow_index].projects[] | @base64" "$preset_file"); do
    _jq() {
      echo "$project" | base64 --decode | jq -r "$@"
    }

    session_name=$(_jq '.session_name')
    project_dir=$(_jq '.project_dir' | sed "s|~|$HOME|")

    first_window=$(_jq '.windows[0].name')
    first_window_cmd=$(_jq '.windows[0].cmd')

    if ! tmux has-session -t=$session_name 2>/dev/null; then
      tmux new -ds $session_name -n $first_window -c $project_dir
      tmux send-keys -t $session_name:1 "$first_window_cmd" C-m
    else
      continue
    fi

    for window in $(_jq '.windows[] | @base64'); do
      __jq() {
        echo "$window" | base64 --decode | jq -r "$@"
      }

      window_name=$(__jq '.name')
      window_dir=$(__jq '.dir' | sed "s|~|$HOME|")
      window_cmd=$(__jq '.cmd')
      window_oneshot=$(__jq '.oneshot')

      if [ "$window_dir" = "null" ]; then
        window_dir=$project_dir
      fi

      if [ "$window_cmd" = "null" ]; then
        window_cmd=
      fi

      if [ "$window_oneshot" == "true" ]; then
        window_oneshot=true
      else
        window_oneshot=false
      fi

      if [ "$window_name" == "$first_window" ]; then
        continue
      fi

      tmux new-window \
        -t $session_name \
        -n $window_name \
        $(if [ -z "$window_dir" ]; then echo ""; else echo "-c $window_dir"; fi) \
        $(if [[ -n "$window_cmd" && "$window_oneshot" == true ]]; then echo "$window_cmd"; fi)

      if [[ -n "$window_cmd" && "$window_oneshot" == false ]]; then
        tmux send-keys -t $session_name:$window_name "$window_cmd" C-m
      fi
    done
  done

  first_session=$(jq -r ".workflows[$workflow_index].projects[0].session_name" "$preset_file")

  # Attach to the first session
  tmux attach -t $first_session:1

  exit 0
fi

# Manually open a project in a new tmux session
paths_file=~/projects/project-paths.json

if [ ! -f "$paths_file" ]; then
  echo "Paths file not found"
  exit 1
fi

# Get project paths from file
project_paths=$(jq -r '.paths[]' "$paths_file" | sed "s|~|$HOME|")
extra_paths=$(jq -r '.extra_paths[]' "$paths_file" | sed "s|~|$HOME|")

project_list=$(echo "$project_paths" | while read -r path; do
  find "$path" -mindepth 1 -maxdepth 1 -type d
done)
project_list=$(echo "$project_list $extra_paths" | tr ' ' '\n')

project_dir=$(echo "$project_list" | fzf --height 40% --reverse --header "Select a project")

if [ -z "$project_dir" ]; then
  exit 0
fi

project_name=$(basename "$project_dir" | tr . _)
tmux_running=$(pgrep tmux)

# If not in tmux, start a new session
if [[ -z $TMUX ]]; then
  tmux new-session -s $project_name -c $project_dir
  exit 0
fi

# If in tmux, create a new session if it doesn't exist
if ! tmux has-session -t=$project_name 2>/dev/null; then
  tmux new-session -ds $project_name -c $project_dir
fi

# Switch to the session
tmux switch-client -t $project_name
