#!/bin/bash
path=$(find /sys 2>/dev/null -name led_rgb | sed "s/led_rgb//g")
echo 0xFF > "$path/brightness"
echo stop > "$path/sequence"
echo $path
