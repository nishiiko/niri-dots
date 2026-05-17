#!/usr/bin/env bash

casts=0

while read -r line; do

	if [[ "$line" == true ]]; then
		((casts++))
	else
		((casts--))
	fi

	if (($casts > 0)); then
		swaync-client --inhibitor-add "xdg-desktop-portal-gnome"
		echo 'WATCH OUT YOURE SCREENSHARING'
		continue
	fi
	echo 'hi'
	swaync-client --inhibitor-remove "xdg-desktop-portal-gnome"

done < <(niri msg --json event-stream | jq -rc --unbuffered 'select(.CastStartedOrChanged) | .CastStartedOrChanged.cast.is_active')
