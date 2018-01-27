#!/bin/bash

path=$1
echo "0 50 50 50  1 200 200 0 2 255 255 255 3 0 0 0" > "$path/led_rgb"
sleep 600
