#!/bin/bash

session_action=${1}

if [[ -z "$session_action" ]]; then
  notify-send "Session action" "Please provide a session action."
  exit 1
fi

case "$session_action" in
"shutdown")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    hyprshutdown -t 'Shutting down...' --no-exit --post-cmd 'systemctl poweroff'
  else
    systemctl poweroff
  fi
  ;;
"reboot")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    hyprshutdown -t 'Restarting...' --no-exit --post-cmd 'systemctl reboot'
  else
    systemctl reboot
  fi
  ;;
"rebootToUefi")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    hyprshutdown -t 'Restarting to UEFI...' --no-exit --post-cmd 'systemctl reboot --firmware-setup'
  else
    systemctl reboot --firmware-setup
  fi
  ;;
"suspend")
  systemctl suspend
  ;;
"hibernate")
  systemctl hibernate
  ;;
"logout")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    hyprshutdown -t 'Logging out...' --no-exit --post-cmd 'uwsm stop'
  else
    uwsm stop
  fi
  ;;
"lock")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    uwsm-app hyprlock
  else
    qs -c noctalia-shell ipc call lockScreen lock
  fi
  ;;
"userspaceReboot")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    hyprshutdown -t 'Restarting userspace...' --no-exit --post-cmd 'systemctl soft-reboot'
  else
    systemctl soft-reboot
  fi
  ;;
*)
  notify-send "Session action" "Invalid session action."
  exit 1
  ;;
esac
