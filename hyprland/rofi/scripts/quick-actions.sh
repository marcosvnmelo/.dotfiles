#!/bin/bash
# filepath: /home/marcos/.dotfiles/hyprland/rofi/scripts/quick-actions.sh

declare -A actions
actions["search"]=" Search"
actions["emulators"]=" Android Emulators"

# Create array of options
options=(
  "${actions["search"]}"
  "${actions["emulators"]}"
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
  sdk_path=~/Android/sdk
  emulator_path=$sdk_path/emulator/emulator
  # Get list of available AVDs
  avd_list=$($emulator_path -list-avds)

  if [[ -z "$avd_list" ]]; then
    notify-send "No Android Virtual Devices found" "Please create an AVD using Android Studio first."
    exit 1
  fi

  avd=$(echo $avd_list | rofi -dmenu -matching fuzzy -i -no-custom -location 0 -p "Search > " -config regular)

  if [[ -z "$avd" ]]; then
    exit
  fi

  gpu_mode=$( (gen_gpu_mode_list) | rofi -dmenu -i -no-custom -location 0 -p "GPU Mode > " -config regular)

  if [[ -z "$gpu_mode" ]]; then
    exit
  fi

  if [[ "$gpu_mode" == "host" ]]; then
    DRI_PRIME=pci-0000_01_00_0 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia
  fi

  nohup $emulator_path "@$avd" -no-snapshot -gpu "${GPU_MODES[$gpu_mode]}" >/dev/null 2>&1 &

  exit
fi

# Handle no valid action
notify-send "Invalid action" "Please select a valid action from the menu."
exit 1
