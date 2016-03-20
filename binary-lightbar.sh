#!/bin/bash

declare -i temp
declare -i l1
declare -i l1r
declare -i l1g
declare -i l1b
declare -i l2
declare -i l2r
declare -i l2g
declare -i l2b
declare -i l3
declare -i l3r
declare -i l3g
declare -i l3b
declare -i l4
declare -i l4r
declare -i l4g
declare -i l4b

number=$1
declare -i number
type=$2  #hour, minute, second

l1=$3+0
l1r=$4+0
l1g=$5+0
l1b=$6+0

l2=$7+0
l2r=$8+0
l2g=$9+0
l2b=${10}+0

l3=${11}+0
l3r=${12}+0
l3g=${13}+0
l3b=${14}+0

l4=${15}+0
l4r=${16}+0
l4g=${17}+0
l4b=${18}+0

if [ "$3" = "" ]; then
	l1=0
fi
if [ "$7" = "" ]; then
	l2=1
fi
if [ "${11}" = "" ]; then
	l3=2
fi
if [ "${15}" = "" ]; then
	l4=3
fi

#hour = red, 1 increment = 255
if [ "$type" = "hour" ]; then
	temp=$number-8
        if [ $temp -gt -1 ]; then
		number+=-8
		l4r+=255
	fi
	temp=$number-4
        if [ $temp -gt -1 ]; then
		number+=-4
		l3r+=255
	fi
	temp=$number-2
        if [ $temp -gt -1 ]; then
                number+=-2
                l2r+=255
        fi
	temp=$number-1
        if [ $temp -gt -1 ]; then
                number+=-1
                l1r+=255
        fi
fi

#min = blue, 1 increment = 127
if [ "$type" = "min" ]; then
	temp=$number-32
        if [ $temp -gt -1 ]; then
		number+=-32
		l4r+=255
	fi
	temp=$number-16
        if [ $temp -gt -1 ]; then
		number+=-16
		l3r+=255
	fi
	temp=$number-8
        if [ $temp -gt -1 ]; then
		number+=-8
		l4b+=255
	fi
	temp=$number-4
        if [ $temp -gt -1 ]; then
		number+=-4
		l3b+=255
	fi
	temp=$number-2
        if [ $temp -gt -1 ]; then
		number+=-2
		l2b+=255
	fi
	temp=$number-1
        if [ $temp -gt -1 ]; then
		number+=-1
		l1b+=255
	fi
fi

#sec = blue, 1 increment = 127
if [ "$type" = "sec" ]; then
	temp=$number-32
        if [ $temp -gt -1 ]; then
		number+=-32
		l2r+=255
	fi
	temp=$number-16
        if [ $temp -gt -1 ]; then
		number+=-16
		l1r+=255
	fi
	temp=$number-8
        if [ $temp -gt -1 ]; then
		number+=-8
		l4g+=255
	fi
	temp=$number-4
        if [ $temp -gt -1 ]; then
		number+=-4
		l3g+=255
	fi
	temp=$number-2
        if [ $temp -gt -1 ]; then
		number+=-2
		l2g+=255
	fi
	temp=$number-1
        if [ $temp -gt -1 ]; then
		number+=-1
		l1g+=255
	fi
fi

echo "$l1 $l1r $l1g $l1b $l2 $l2r $l2g $l2b $l3 $l3r $l3g $l3b $l4 $l4r $l4g $l4b"
