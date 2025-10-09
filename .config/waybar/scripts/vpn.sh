#!/bin/bash

mullvad status | grep -e "Connected" -e "Connecting" &>/dev/null \
&& ip=$(curl -s4 https://icanhazip.com) \
&& jq -c -n --arg ip "$ip" '{"text":$ip,"class":"connected","percentage":100}' \
|| echo '{"text":"VPN Disconnected","class":"disconnected","percentage":0}'
