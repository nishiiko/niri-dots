#!/usr/bin/env bash
read -r state country city <<< $(mullvad status --json | jq -r '.state, .details.location.country, .details.location.city' | tr '\n' ' ')

if [ "$state" = "connected" ]; then
  mullvad disconnect
  notify-send "VPN Toggle" "Disconnecting from $country, $city..." -ae niri-script
else
  mullvad connect
  until mullvad status --json | grep connecting; do
    :
  done
    read -r country city <<< $(mullvad status --json | jq -r '.details.location | .country, .city' | tr '\n' ' ')
  notify-send "VPN Toggle" "Connecting to $country, $city..." -ae niri-script

fi
