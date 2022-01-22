#!/usr/bin/env bash

brightness=$(brightnessctl -m | cut -d ',' -f 4)
brightness=${brightness::-1}
echo $brightness
