#!/bin/bash

# NOTE: Save a screenshot from the /tmp directory to xdg-screenshot directory
# Usage: ~/.local/bin/save-temp-screenshot.sh <filepath>

filepath="${1}"
SCREENSHOTS_DIR="$XDG_PICTURES_DIR/Screenshots"

DMENU="vicinae" # rofi | vicinae
IMG_VIEWER="loupe"

if [[ -z "$filepath" ]]; then
  notify-send "Save screenshot" "Please provide a filepath."
  exit 1
fi

if [[ ! -f "$filepath" ]]; then
  notify-send "Save screenshot" "File not found."
  exit 1
fi

function _send_notification() {
  local icon="${1}"
  local filepath="${2:-"$icon"}"
  local message="${3}"

  local notification_action=$(notify-send \
    --app-name "Hyprshot" \
    --urgency low \
    --icon "$icon" \
    --action "open=Open" \
    "Screenshot saved" \
    "$message")

  if [[ "$notification_action" == "open" ]]; then
    $IMG_VIEWER "$filepath"
  fi
}

declare chosen_action=""

declare -A actions=(
  ["open"]=" Open"
  ["save"]=" Save"
  ["discard"]=" Discard"
)

# Create array of options
declare -a options=(
  "${actions["open"]}"
  "${actions["save"]}"
  "${actions["discard"]}"
)

case "$DMENU" in
"rofi")
  chosen_action=$(printf "%s\n" "${options[@]}" | rofi -dmenu -matching fuzzy -i -no-custom -location 0 -p "Screenshot > " -config regular)
  ;;
"vicinae")
  chosen_action=$(printf "%s\n" "${options[@]}" | vicinae dmenu --no-footer -p "Screenshot > ")
  ;;
esac

case "$chosen_action" in
"${actions["open"]}")
  $IMG_VIEWER "$filepath"

  _send_notification "$filepath" "" "Image copied to clipboard."
  ;;
"${actions["save"]}")
  # Create the directory if it doesn't exist
  mkdir -p "$SCREENSHOTS_DIR"

  declare new_filepath="$SCREENSHOTS_DIR/$(basename "$filepath")"

  # Copy the file to the xdg-screenshots directory
  cp "$filepath" "$new_filepath"

  _send_notification "$filepath" "$new_filepath" "Image saved in $new_filepath and copied to clipboard."
  ;;
"${actions["discard"]}")
  exit
  ;;
esac
