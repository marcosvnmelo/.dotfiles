#!/usr/bin/bash

# map function, replace using sed
args=$(for i in "$@"; do sed s/\-\-/\-e/g <<< "$i"; done)
args=$(for i in "$args"; do sed s/\-\x/\-e/g <<< "$i" ; done)
args=$(for i in "$args"; do sed s/\-\w/\-\-working\-directory/g <<< "$i" ; done)
args=$(for i in "$args"; do sed s/\-ewindow//g <<< "$i" ; done)
args=$(for i in "$args"; do sed s/\-\-window//g <<< "$i" ; done)

log=$(mktemp)
printf "command that was run: ghostty $args\n\n" > $log
[ $EDITOR ] || EDITOR=vi
((ghostty $args >> $log || ghostty -e $EDITOR $log) && rm -f $log) &
