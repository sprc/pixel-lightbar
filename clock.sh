#!/bin/bash

dn=0
path=$(sh init.sh)
sec=0
min=0
hr=0
count=0
declare -i count
declare -i sec
declare -i min
declare -i hour

while [ $dn -lt 1 ]; do
	#hour=`date +"%-H"`
	min=`date +"%-M"`
	sec=`date +"%-S"`
	bar=""
	#bar=$(bash binary-lightbar.sh "$hour" "hour")
	bar=$(bash binary-lightbar.sh "$min" "min" $bar)
	bar=$(bash binary-lightbar.sh "$sec" "sec" $bar)
	#echo "$hour:$min:$sec - "$bar
	echo $min:$sec
	echo "$bar" > "$path/led_rgb"
	count=$count+1
	if [ $count -gt 4800 ]; then
		dn=1
	fi
	sleep 0.47
done
