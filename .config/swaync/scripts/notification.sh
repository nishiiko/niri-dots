#!/usr/bin/env bash

if [ $(swaync-client -D) = "false" ]; then
	pw-cat -p --volume 1 $HOME/.config/swaync/jet-set-radio.ogg
fi
