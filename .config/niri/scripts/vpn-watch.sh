#!/usr/bin/env bash

lastline=

while read -r line; do
	if echo $line | grep "mullvad.*UP" || \
	echo $line | grep "Deleted"; then
		pkill -RTMIN+8 waybar
	fi
done < <(ip monitor link)
