#!/bin/bash
cd /sys/devices/platform/cros_ec_lpc.0/cros-ec-dev.0/chromeos/cros_ec/lightbar
echo 0xFF > brightness
echo stop > sequence
for i in 1 2 3 4 5
do
	echo "0 255 0 0  1 0 0 0  2 0 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 255 0 0  2 0 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 0 0 0  2 255 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 0 0 0  2 0 0 0  3 255 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 0 0 0  2 255 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 255 0 0  2 0 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 125 0 0  1 0 0 0  2 0 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 125 0 0  2 0 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 0 0 0  2 125 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 0 0 0  2 0 0 0  3 125 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 0 0 0  2 125 0 0  3 0 0 0" > led_rgb
	sleep .1
	echo "0 0 0 0  1 125 0 0  2 0 0 0  3 0 0 0" > led_rgb
	sleep .1
done
cd ~
sh reset-lightbar.sh
