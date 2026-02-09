#!/bin/bash

_get_idle_status() {
  local is_active
  if [[ "$(systemctl --user is-active hypridle.service)" == "active" ]]; then
    is_active=true
  else
    is_active=false
  fi

  return_format=${1:-"plain"}

  if [[ "$return_format" == "plain" ]]; then
    echo "$is_active"
  elif [[ "$return_format" == "emoji" ]]; then
    [[ "$is_active" == true ]] && echo "🟢 Active" || echo "🔴 Inactive"
  fi
}

_get_docker_status() {
  local is_something_running
  if [[ "$(docker ps -q)" != "" ]]; then
    is_something_running=true
  else
    is_something_running=false
  fi

  return_format=${1:-"plain"}

  if [[ "$return_format" == "plain" ]]; then
    echo "$is_something_running"
  elif [[ "$return_format" == "emoji" ]]; then
    [[ "$is_something_running" == true ]] && echo "🟢 Running" || echo "🔴 Stopped"
  fi
}

declare -A actions
actions["search"]=" Search"
actions["emulators"]=" Android Emulators"
actions["toggle_idle"]=" Toggle Idle Service $(_get_idle_status 'emoji')"
actions["stop_docker"]=" Stop Docker $(_get_docker_status 'emoji')"
actions["clean_swap"]="󰃢 Clean Swap"

# Create array of options
options=(
  "${actions["search"]}"
  "${actions["emulators"]}"
  "${actions["toggle_idle"]}"
  "${actions["stop_docker"]}"
  "${actions["clean_swap"]}"
)

# Present main menu with proper formatting
chosen_action=$(printf "%s\n" "${options[@]}" | rofi -dmenu -i -config regular -p "󰅒 Quick Actions")

# Exit if no selection
if [[ -z "$chosen_action" ]]; then
  exit
fi

# Handle search submenu
declare -A URLS

URLS=(
  ["Google"]="https://www.google.com/search?q="
  ["Youtube"]="https://www.youtube.com/results?search_query="
  ["NPM"]="https://www.npmjs.com/search?q="
  ["Github"]="https://github.com/search?q="
  ["Stackoverflow"]="http://stackoverflow.com/search?q="
  ["Duckduckgo"]="https://www.duckduckgo.com/?q="
  ["ArchPackages"]="https://archlinux.org/packages/?q="
  ["AUR"]="https://aur.archlinux.org/packages?O=0&SeB=nd&outdated=&SB=p&SO=d&PP=50&submit=Go&K="
  ["Translate"]="https://translate.google.com/?sl=auto&tl=en&op=translate&text="
  ["Context7"]="https://context7.com/?q="
)

gen_url_list() {
  echo "Google"
  echo "Youtube"
  echo "NPM"
  echo "Github"
  echo "Stackoverflow"
  echo "Duckduckgo"
  echo "ArchPackages"
  echo "AUR"
  echo "Translate"
  echo "Context7"
}

if [[ "$chosen_action" == "${actions["search"]}" ]]; then
  platform=$( (gen_url_list) | rofi -dmenu -matching fuzzy -i -no-custom -location 0 -p "Search > " -config regular)

  if [[ -n "$platform" ]]; then
    query=$( (echo) | rofi -dmenu -matching fuzzy -location 0 -p "Query > " -config input)

    if [[ -n "$query" ]]; then
      url=${URLS[$platform]}$query
      xdg-open "$url"
      exit
    else
      exit
    fi

  else
    exit
  fi
fi

# Handle Android emulators submenu
declare -A GPU_MODES

GPU_MODES["GPU (⚡ Fast)"]="host"
GPU_MODES["CPU (🐢 Slow)"]="swiftshader_indirect"

gen_gpu_mode_list() {
  echo "GPU (⚡ Fast)"
  echo "CPU (🐢 Slow)"
}

if [[ "$chosen_action" == "${actions["emulators"]}" ]]; then
  sdk_path=~/Android/Sdk
  emulator_path=$sdk_path/emulator/emulator
  # Get list of available AVDs
  avd_list=$($emulator_path -list-avds)

  if [[ -z "$avd_list" ]]; then
    notify-send "No Android Virtual Devices found" "Please create an AVD using Android Studio first."
    exit 1
  fi

  gen_avd_list() {
    for avd in $avd_list; do
      echo "$avd"
    done
  }

  avd=$( (gen_avd_list) | rofi -dmenu -matching fuzzy -i -no-custom -location 0 -p "Search > " -config regular)

  if [[ -z "$avd" ]]; then
    exit
  fi

  gpu_mode=$( (gen_gpu_mode_list) | rofi -dmenu -i -no-custom -location 0 -p "GPU Mode > " -config regular)

  if [[ -z "$gpu_mode" ]]; then
    exit
  fi

  emulator_cmd="$emulator_path \@$avd -no-boot-anim -no-snapshot -gpu ${GPU_MODES[$gpu_mode]}"

  if [[ "GPU_MODES[$gpu_mode]" != "host" ]]; then
    tmux new-session -d -s android-emulator \
      -e LIBVA_DRIVER_NAME=nvidia \
      -e GBM_BACKEND=nvidia-drm \
      -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
      "$emulator_cmd"
  fi

  tmux new-session -d -s android-emulator "$emulator_cmd"

  exit
fi

# Handle idle service submenu
if [[ "$chosen_action" == "${actions["toggle_idle"]}" ]]; then
  is_active=$(_get_idle_status)

  if [[ "$is_active" == "true" ]]; then
    systemctl --user stop hypridle.service
    notify-send "Idle service" "Idle service has been stopped."
  else
    systemctl --user start hypridle.service
    notify-send "Idle service" "Idle service has been started."
  fi

  exit
fi

# Handle docker submenu
if [[ "$chosen_action" == "${actions["stop_docker"]}" ]]; then
  is_something_running=$(_get_docker_status)

  if [[ "$is_something_running" == "true" ]]; then
    docker stop $(docker ps -q)
    notify-send "Docker" "Docker containers have been stopped."
  else
    notify-send "Docker" "No containers are running."
  fi

  exit
fi

# Handle clean swap submenu
if [[ "$chosen_action" == "${actions["clean_swap"]}" ]]; then
  pkexec bash -c "sudo swapoff -a && sudo swapon -a"
  notify-send "Swap" "Swap has been cleaned."
  exit
fi

# Handle no valid action
notify-send "Invalid action" "Please select a valid action from the menu."
exit 1
