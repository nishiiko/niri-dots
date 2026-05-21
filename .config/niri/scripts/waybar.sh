#!/usr/bin/env bash
sleep 0.1s

while true; do
	pkill -x waybar
	waybar &
	for i in {1..30}; do
		sleep 0.1s
		if niri msg --json layers \
			| jq '.[].namespace' \
			| grep waybar; then
			break 2
		fi
	done
	continue
done
