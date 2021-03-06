#!/usr/bin/env bash

pamixer --get-volume | cut -d " " -f1;
pactl subscribe | grep --line-buffered "Event 'change' on sink " | \
    while read -r evt; do
        pamixer --get-volume | cut -d " " -f1;
    done
