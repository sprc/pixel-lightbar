#!/bin/bash
path=$1
if [ " $path" = " " ]; then
	path=$(sh init.sh)
fi

if [ " $path" = " " ]; then
	echo "reset-lightbar.sh: Could not find path!"
else
	echo run > "$path/sequence"
	echo S0 > "$path/sequence"
fi
