#!/usr/bin/env bash

if ! grep -r systemd /sbin/init; then
	# && ! ls /usr/bin/ | grep openrc-init; then
	gentoo-pipewire-launcher &
fi
sleep 3s
pw-cat -p $HOME/.config/niri/scripts/assets/heal.wav &
