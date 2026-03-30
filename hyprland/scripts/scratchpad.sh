#!/bin/bash

# Scratchpad for Hyprland

SCRATCHPAD_NAME=${1}
APP_CLASS=${2}
OPEN_APP_CMD=${3}

if [[ -z "$SCRATCHPAD_NAME" ]]; then
  notify-send "Scratchpad" "Please provide a name for the scratchpad."
  exit 1
fi

if [[ -z "$APP_CLASS" ]]; then
  notify-send "Scratchpad" "Please provide an application class."
  exit 1
fi

function _move_to_scratchpad() {
  hyprctl dispatch movetoworkspace special:$SCRATCHPAD_NAME, class:$APP_CLASS
}

function _toggle_scratchpad() {
  hyprctl dispatch togglespecialworkspace $SCRATCHPAD_NAME
}

function _open_app() {
  fish -c "$OPEN_APP_CMD"
}

function _check_if_app_running() {
  hyprctl clients | rg "$APP_CLASS"
}

function _check_if_app_focused() {
  hyprctl activewindow | rg "$APP_CLASS"
}

is_app_running=$(_check_if_app_running)
is_app_focused=$(_check_if_app_focused)

if [[ -n "$is_app_focused" ]]; then
  _move_to_scratchpad
  _toggle_scratchpad
  exit 0
fi

if [[ -z "$is_app_running" ]]; then
  _open_app
  exit 0
fi

_toggle_scratchpad
_move_to_scratchpad
