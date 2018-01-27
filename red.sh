#!/bin/bash

path=$1
#echo "0 225 240 255  1 128 170 200  2 64 100 130  3 32 40 70" > "$path/led_rgb"
#echo "0 120 0 0  1 90 0 0  2 60 0 0  3 30 0 0" > "$path/led_rgb"
#echo "4 180 0 0" > "$path/led_rgb"
#echo "4 255 120 0" > "$path/led_rgb"
echo "4 255 50 0" > "$path/led_rgb"
sleep 600
