#!/usr/bin/env bash

if ! grep -r systemd /sbin/init; then
	# && ! ls /usr/bin/ | grep openrc-init; then
	gentoo-pipewire-launcher restart &
fi
sleep 0.5s
pw-cat -p $HOME/.config/niri/scripts/assets/heal.wav &
