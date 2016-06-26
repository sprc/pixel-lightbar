#!/bin/bash

path=$1
echo "0 150 255 0  1 255 255 0  2 255 150 50  3 255 50 50" > "$path/led_rgb"
sleep 10
