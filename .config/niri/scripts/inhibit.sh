#!/usr/bin/env bash

casts=()

screencastCheck () {
	if [ "$screencastIsActive" == false ]; then
		echo "false"
		return
	fi

	if [ "$screencastTarget" = "{\"Nothing\":{}}" ]; then
		echo "false"
		return
	fi

	if [[ ${casts[@]} =~ $screencastStream ]]; then
		echo "null"
		return
	fi

	echo "true"
	return
}

while read -r line; do

	screencastIsActive=$(echo $line | jq -rc '.CastStartedOrChanged.cast.is_active')
	screencastTarget=$(echo $line | jq -rc '.CastStartedOrChanged.cast.target')
	screencastStream=$(echo $line | jq -rc ' .CastStartedOrChanged.cast.stream_id')
	screencastStatus=$(screencastCheck)

	printf "\n$screencastIsActive"
	printf "\n$screencastTarget"
	printf "\n$screencastStream"
	printf "\n$screencastStatus"

	if [ "$screencastStatus" == true ]; then
		printf "\nAdding $screencastStream"
		casts+=$screencastStream
	elif [ "$screencastStatus" == "false" ]; then
		casts=(${casts[@]/$screencastStream})
	fi
	printf "\nCasts: ${casts[@]}"

	if (( ${#casts[@]} != 0 )); then
		printf "\n"
		swaync-client --inhibitor-add "xdg-desktop-portal-gnome"
		printf "\nWATCH OUT YOURE SCREENSHARING"
	else
		printf "\nRemoving inhibitor\n"
		swaync-client --inhibitor-remove "xdg-desktop-portal-gnome"
	fi

done < <(niri msg --json event-stream | jq -rc --unbuffered 'select(.CastStartedOrChanged)')
