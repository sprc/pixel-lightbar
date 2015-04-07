#!/bin/bash
cd /sys/devices/platform/cros_ec_lpc.0/cros-ec-dev.0/chromeos/cros_ec/lightbar
echo 0xFF > brightness
echo stop > sequence
for i in 1 to 30
do
	echo "0 0 0 255  1 0 0 255  2 255 255 0  3 0 0 255" > led_rgb
	sleep 2
	echo "0 0 0 255  1 0 0 255  2 255 255 0  3 175 175 255" > led_rgb
	sleep 2
	echo "0 0 0 255  1 0 0 255  2 255 255 0  3 255 255 255" > led_rgb
	sleep 2
	echo "0 100 100 150  1 100 100 150  2 255 255 125  3 175 175 255" > led_rgb
	sleep 2
	echo "0 125 125 100  1 125 125 100  2 255 255 200  3 125 125 100" > led_rgb
	sleep 4
	echo "0 100 100 150  1 175 175 255  2 255 255 125  3 100 100 150" > led_rgb
	sleep 2
	echo "0 0 0 255  1 255 255 255  2 255 255 0  3 0 0 255" > led_rgb
	sleep 2
	echo "0 175 175 255  1 175 175 255  2 255 255 0  3 0 0 255" > led_rgb
	sleep 2
	echo "0 255 255 255  1 0 0 255  2 255 255 0  3 0 0 255" > led_rgb
	sleep 2
	echo "0 175 175 255  1 0 0 255  2 255 255 0  3 0 0 255" > led_rgb
	sleep 2
	echo "0 0 0 255  1 0 0 255  2 255 255 0  3 0 0 255" > led_rgb
	sleep 2
done
cd ~
sh lightbar.sh
