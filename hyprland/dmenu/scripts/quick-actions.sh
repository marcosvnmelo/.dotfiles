#!/bin/bash

# NOTE: Get dmenu name from first argument
# rofi | vicinae
DMENU=${1:-"rofi"}
# hypridle | noctalia-idle
IDLE_SERVICE="noctalia-idle"

function get_idle_status() {
  local is_active=false
  case "$IDLE_SERVICE" in
  "hypridle")
    if [[ "$(systemctl --user is-active hypridle.service)" == "active" ]]; then
      is_active=true
    fi
    ;;

  "noctalia-idle")
    ;;
  esac

  return_format=${1:-"plain"}

  case "$return_format" in
  "plain")
    echo "$is_active"
    ;;
  "emoji")
    [[ "$is_active" == true ]] && echo "🟢 Active" || echo "🔴 Inactive"
    ;;
  esac
}

function get_docker_status() {
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

function print_options() {
  printf "%s\n" "$@"
}

declare -A ACTIONS=(
  ["search"]=" Search"
  ["emulators"]=" Android Emulators"
  ["toggle_idle"]=" Toggle Idle Service $(get_idle_status 'emoji')"
  ["stop_docker"]=" Stop Docker $(get_docker_status 'emoji')"
  ["clean_swap"]="󰃢 Clean Swap"
  ["toggle_statusbar"]=" Toggle Statusbar"
)

# HACK: Create array of options in the correct order,
# since expanding associative arrays doesn't keep the order
declare -a OPTIONS=(
  "${ACTIONS["search"]}"
  "${ACTIONS["emulators"]}"
  "${ACTIONS["toggle_idle"]}"
  "${ACTIONS["stop_docker"]}"
  "${ACTIONS["clean_swap"]}"
  "${ACTIONS["toggle_statusbar"]}"
)

# HACK: Remove idle service from options if it's not running hypridle
if [[ "$IDLE_SERVICE" == "noctalia-idle" ]]; then
  unset 'OPTIONS[2]'
  OPTIONS=("${OPTIONS[@]}")
fi

# Present main menu with proper formatting
case "$DMENU" in
"rofi")
  chosen_action=$(print_options "${OPTIONS[@]}" | rofi -dmenu -i -config regular -p "󰅒 Quick Actions")
  ;;
"vicinae")
  chosen_action=$(print_options "${OPTIONS[@]}" | vicinae dmenu --no-footer -p "󰅒 Quick Actions")
  ;;
esac

# Exit if no selection
if [[ -z "$chosen_action" ]]; then
  exit
fi

case "$chosen_action" in
"${ACTIONS["search"]}") # Handle search submenu
  declare -A URLS=(
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

  declare -a URL_OPTIONS=(
    "Google"
    "Youtube"
    "NPM"
    "Github"
    "Stackoverflow"
    "Duckduckgo"
    "ArchPackages"
    "AUR"
    "Translate"
    "Context7"
  )

  declare platform=""

  case "$DMENU" in
  "rofi")
    platform=$( (print_options ${URL_OPTIONS[@]}) | rofi -dmenu -matching fuzzy -i -no-custom -location 0 -p "Search > " -config regular)
    ;;
  "vicinae")
    platform=$( (print_options ${URL_OPTIONS[@]}) | vicinae dmenu --no-footer -p "Search > ")
    ;;
  esac

  if [[ -n "$platform" ]]; then
    query=$(rofi -dmenu -matching fuzzy -location 0 -p "Query > " -config input)
    # NOTE: Vicinae stopped returning the query when there's no options to select
    # if [[ "$DMENU" == "rofi" ]]; then
    #   query=$(rofi -dmenu -matching fuzzy -location 0 -p "Query > " -config input)
    # else
    #   query=$(vicinae dmenu --no-footer -p "Query > ")
    # fi

    if [[ -n "$query" ]]; then
      url="${URLS[$platform]}$query"
      xdg-open "$url"
      exit
    else
      exit
    fi

  else
    exit
  fi
  ;;

"${ACTIONS["emulators"]}") # Handle Android emulators submenu
  declare -A GPU_MODES=(
    ["host"]="GPU (⚡ Fast)"
    ["swiftshader_indirect"]="CPU (🐢 Slow)"
  )

  declare -a GPU_MODE_OPTIONS=(
    "${GPU_MODES["host"]}"
    "${GPU_MODES["swiftshader_indirect"]}"
  )

  declare sdk_path=~/Android/Sdk
  declare emulator_path=$sdk_path/emulator/emulator
  # Get list of available AVDs
  declare avd_list="$($emulator_path -list-avds)"

  if [[ -z "$avd_list" ]]; then
    notify-send "No Android Virtual Devices found" "Please create an AVD using Android Studio first."
    exit 1
  fi

  declare avd=""

  case "$DMENU" in
  "rofi")
    avd=$(print_options "$avd_list" | rofi -dmenu -matching fuzzy -i -no-custom -location 0 -p "Search > " -config regular)
    ;;
  "vicinae")
    avd=$(print_options "$avd_list" | vicinae dmenu --no-footer -p "Search > ")
    ;;
  esac

  if [[ -z "$avd" ]]; then
    exit
  fi

  declare gpu_mode=""

  case "$DMENU" in
  "rofi")
    gpu_mode=$(print_options "${GPU_MODE_OPTIONS[@]}" | rofi -dmenu -i -no-custom -location 0 -p "GPU Mode > " -config regular)
    ;;
  "vicinae")
    gpu_mode=$(print_options "${GPU_MODE_OPTIONS[@]}" | vicinae dmenu --no-footer -p "GPU Mode > ")
    ;;
  esac

  if [[ -z "$gpu_mode" ]]; then
    exit
  fi

  declare emulator_cmd="$emulator_path \@$avd -no-boot-anim -no-snapshot -gpu ${GPU_MODES[$gpu_mode]}"

  if [[ "GPU_MODES[$gpu_mode]" != "host" ]]; then
    tmux new-session -d -s android-emulator \
      -e LIBVA_DRIVER_NAME=nvidia \
      -e GBM_BACKEND=nvidia-drm \
      -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
      "$emulator_cmd"
  fi

  tmux new-session -d -s android-emulator "$emulator_cmd"

  until [[ -n "$(hyprctl clients -j | jq -r '.[] | select(.class == "Emulator") | .pid')" ]]; do sleep 1; done

  sleep 3

  hyprctl dispatch settiled "title:^.*Android Emulator.*$"

  sleep 3

  hyprctl dispatch resizewindowpixel "445 100%,title:^.*Android Emulator.*$"

  exit
  ;;

"${ACTIONS["toggle_idle"]}") # Handle idle service submenu
  is_active=$(get_idle_status)

  if [[ "$is_active" == "true" ]]; then
    systemctl --user stop hypridle.service
    notify-send "Idle service" "Idle service has been stopped."
  else
    systemctl --user start hypridle.service
    notify-send "Idle service" "Idle service has been started."
  fi

  exit
  ;;

"${ACTIONS["stop_docker"]}") # Handle docker submenu
  is_something_running=$(get_docker_status)

  if [[ "$is_something_running" == "true" ]]; then
    docker stop $(docker ps -q)
    notify-send "Docker" "Docker containers have been stopped."
  else
    notify-send "Docker" "No containers are running."
  fi

  exit
  ;;

"${ACTIONS["clean_swap"]}") # Handle clean swap submenu
  pkexec bash -c "sudo swapoff -a && sudo swapon -a"
  notify-send "Swap" "Swap has been cleaned."
  exit
  ;;

"${ACTIONS["toggle_statusbar"]}") # Handle toggle statusbar submenu
  qs -c noctalia-shell kill || uwsm-app -- qs -c noctalia-shell

  exit
  ;;
*) # Handle no valid action
  notify-send "Invalid action" "Please select a valid action from the menu."
  exit 1
  ;;
esac
