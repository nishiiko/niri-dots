#!/usr/bin/env bash

lockdir=$HOME/.vpnScript
vpn_ip=
state=$(ivpn status | grep "^VPN" )
state="${state#*: }"
sleep 0.2s

until [ ! -e $lockdir ]; do
	state=$(ivpn status | grep "^VPN" )
	state="${state#*: }"
done

if [ "$state" = "DISCONNECTED" ]; then
	echo '{"text":"VPN Disconnected","class":"disconnected","percentage":0}'
	exit
fi

state=$(ivpn status | grep '^VPN' )
state="${state#*: }"

vpn_ip=$(curl -s4 --json "" ip.wtf | jq -r '"\(.ip) \(.location.country)"')

if [[ -n "$vpn_ip" ]]; then
	jq -c -n --arg ip "$vpn_ip" '{"text":$ip,"class":"connected","percentage":100}'
fi
