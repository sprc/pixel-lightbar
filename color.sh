#!/bin/bash

path=$(sh init.sh)

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

sh cycle.sh $path

echo "4 $R $G $B" > "$path/led_rgb"
sleep .2
echo "4 255 255 255" > "$path/led_rgb"
sleep .2
echo "4 $Rw $Gw $Bw" > "$path/led_rgb"
sleep .2
echo "4 $R $G $B" > "$path/led_rgb"

sleep 300 && sh reset-lightbar.sh $path
