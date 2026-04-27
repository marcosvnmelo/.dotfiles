#!/bin/bash

# NOTE: Execute a session action using hyprshutdown if running on Hyprland
# Usage: ~/.local/bin/session-action.sh <action>

session_action=${1}

if [[ -z "$session_action" ]]; then
  notify-send "Session action" "Please provide a session action."
  exit 1
fi

case "$session_action" in
"shutdown")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    hyprshutdown -t 'Shutting down...' --no-exit

    sleep 1

    until [[ -z "$(pgrep 'hyprshutdown')" ]]; do
      sleep 1
    done
  fi

  systemctl poweroff
  ;;
"reboot")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    hyprshutdown -t 'Restarting...' --no-exit --post-cmd 'systemctl reboot'

    sleep 1

    until [[ -z "$(pgrep 'hyprshutdown')" ]]; do
      sleep 1
    done
  fi

  systemctl reboot
  ;;
"rebootToUefi")
  if [[ "$XDG_SESSION_DESKTOP" == "Hyprland" ]]; then
    hyprshutdown -t 'Restarting to UEFI...' --no-exit --post-cmd 'systemctl reboot --firmware-setup'

    sleep 1

    until [[ -z "$(pgrep 'hyprshutdown')" ]]; do
      sleep 1
    done
  fi

  systemctl reboot --firmware-setup
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

    sleep 1

    until [[ -z "$(pgrep 'hyprshutdown')" ]]; do
      sleep 1
    done
  fi

  uwsm stop
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

    sleep 1

    until [[ -z "$(pgrep 'hyprshutdown')" ]]; do
      sleep 1
    done
  fi

  systemctl soft-reboot
  ;;
*)
  notify-send "Session action" "Invalid session action."
  exit 1
  ;;
esac
