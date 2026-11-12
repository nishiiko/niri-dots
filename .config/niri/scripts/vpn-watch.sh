#!/usr/bin/env bash

lastline=

while read -r line; do
	if echo $line | grep "wgivpn.*UP" || \
	echo $line | grep "Deleted"; then
		bash $HOME/.config/waybar/scripts/toggle.sh
	fi
done < <(ip monitor link)
