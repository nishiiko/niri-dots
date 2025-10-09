#!/bin/bash

vpn=wg0-mullvad

while read -r line; do
    echo $line | grep wg0-mullvad \
    && pkill -RTMIN+8 waybar
done < <(ip monitor link)
