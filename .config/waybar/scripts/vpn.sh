#!/usr/bin/env bash

vpn_ip=
sleep 0.2s

state=$(mullvad status --json | jq -r '.state')

if [ "$state" = "disconnected" ] || [ "$state" = "disconnecting" ] ; then
	echo '{"text":"VPN Disconnected","class":"disconnected","percentage":0}'
	exit
fi

for i in {1..100}; do
	if [ "$state" != "connected" ]; then
		sleep 0.1s
		state=$(mullvad status --json | jq -r '.state')
		continue
	fi
	break
done


if [ "$state" != "connected" ]; then
	echo '{"text":"VPN Disconnected","class":"disconnected","percentage":0}'
	mullvad disconnect
	notify-send "VPN Status" "Failed to connect" -ae niri-script
	exit
fi

read -r country city <<< $(mullvad status --json | jq -rj '.details.location | .country, " ", .city')
vpn_ip=$(curl -s4 ipinfo.io | jq -r '"\(.ip) \(.country)"')
if [[ -n "$vpn_ip" ]]; then
	jq -c -n --arg ip "$vpn_ip" '{"text":$ip,"class":"connected","percentage":100}'
	notify-send "VPN State" "Connected to $country, $city" -ae niri-script
fi
