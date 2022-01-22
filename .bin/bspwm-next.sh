#!/usr/bin/env bash

if [[ "$1" == "prev" ]]; then
    action="prev"
else
    action="next"
fi


if [[ $( bspc wm --dump-state | jq --raw-output ".monitors[].desktops[] | select(.id == $(printf '%d' $(bspc query --desktops --desktop))).layout" ) != "tiled" ]]; then
	while bspc node any.hidden.local.window -g hidden=off; do :; done
	bspc node -f $action.local.window
    current=$( bspc query -N -n )
	while bspc node 'any.!hidden.local.window' -g hidden=on; do :; done
	bspc node $current -g hidden=off
else
	bspc node -f $action.local.!hidden.window
fi
