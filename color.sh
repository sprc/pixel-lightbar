#!/bin/bash

path=$(init.sh)

Rw=230
Gw=255
Bw=195

R=$1
if [ " " = " $1" ]; then
	R=$Rw
fi

G=$2
if [ " " = " $2" ]; then
        G=$Gw
fi

B=$3
if [ " " = " $3" ]; then
        B=$Bw
fi

echo "4 $R $G $B" > "$path/led_rgb"

sleep 60
