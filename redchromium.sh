#!/bin/bash

path=$1
#echo "0 225 240 255  1 128 170 200  2 64 100 130  3 32 40 70" > "$path/led_rgb"
echo "0 255 190 130  1 255 100 70  2 200 75 32  3 170 20 16" > "$path/led_rgb"
sleep 600
