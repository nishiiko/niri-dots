#!/usr/bin/env bash

lockdir=$HOME/.vpnScript
vpn_ip=
state=
sleep 0.2s

until [ ! -e $lockdir ]; do
	state=$(ivpn status | grep '^VPN' )
	state="${state#*: }"
done

notify-send $state

if [ "$state" = "DISCONNECTED" ]; then
	echo '{"text":"VPN Disconnected","class":"disconnected","percentage":0}'
	exit
fi

until [ "$state" = "CONNECTED" ]; do
	state=$(ivpn status | grep '^VPN' )
	state="${state#*: }"
	sleep 0.1s
done

vpn_ip=$(curl -s4 ipinfo.io | jq -r '"\(.ip) \(.country)"')

wait $!

if [[ -n "$vpn_ip" ]]; then
	jq -c -n --arg ip "$vpn_ip" '{"text":$ip,"class":"connected","percentage":100}'
fi
