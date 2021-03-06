#!/usr/bin/env bash

bspc subscribe all | while read -r event mon desktop mode state; do
    current=$( bspc query -N -n )
    if [[ $mode == "monocle" || $state == "fullscreen on" ]]; then
        while bspc node 'any.!hidden.local.window' -g hidden=on; do :; done
        bspc node $current -g hidden=off
    fi
    if [[ $mode == "tiled" || $state == "tiled on" ]]; then
        while bspc node any.hidden.local.window -g hidden=off; do :; done
    fi
done
