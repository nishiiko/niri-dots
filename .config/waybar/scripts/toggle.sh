#!/usr/bin/env bash
read -r state country city <<< $(mullvad status --json | jq -rj '.state, " ", .details.location.country, " ", .details.location.city')

if [ "$state" = "connected" ]; then
  mullvad disconnect
  notify-send "VPN State" "Disconnected from $country, $city" -ae niri-script
else
  mullvad connect
  for i in {1..100}; do
    if [ "$state" != "connected" ]; then
      sleep 0.1s
      state=$(mullvad status --json | grep connect)
      continue
    fi
    break
  done
  read -r country city <<< $(mullvad status --json | jq -rj '.details.location | .country, " ", .city' | tr '\n' ' ')
  notify-send "VPN State" "Connecting to $country, $city..." -ae niri-script
fi
