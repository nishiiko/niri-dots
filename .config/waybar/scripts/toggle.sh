#!/usr/bin/env bash

lockdir=$HOME/.vpnScript

if [ -e $lockdir ]; then
  echo "locked - remove $lockdir"
  exit
fi

trap 'rm -rf $lockdir' EXIT

mkdir -p $lockdir
touch $lockdir/tempfile
echo 'you can remove this directory, its a waybar temp file' > $lockdir/tempfile

if [[ $(ivpn status | grep '^VPN *: CONNECTED$') ]]; then
  ivpn disconnect
else
  ivpn connect -protocol wireguard -f
  for i in {1..100}; do
    if [[ $(ivpn status | grep '^VPN *: CONNECTED$') ]]; then
      break
    fi
    sleep 0.1s
  done
  info=$(ivpn status | grep \( | head -1)
  info="${info#*, }"
  echo $info
fi

exit
