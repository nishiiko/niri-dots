#!/usr/bin/env bash

if [[ $(ivpn status | grep '^VPN *: CONNECTED$') ]]; then
  ivpn disconnect
else
  ivpn connect -protocol wireguard -f
  for i in {1..100}; do
    if [[ $(ivpn status | grep '^VPN *: CONNECTED$') ]]; then
      continue
    fi
    sleep 0.1s
  done
  info=$(ivpn status | grep \( | head -1)
  info="${info#*, }"
  echo $info
fi
