#!/usr/bin/env bash

update_state()
{
  state=$(ivpn status | grep "^VPN")
  state="${state#*: }"
}

lockdir=$HOME/.vpnScript

if [ -e $lockdir/tempfile ]; then
  echo "locked - remove $lockdir"
  exit
fi

trap 'rm -rf $lockdir' EXIT

mkdir -p $lockdir
touch $lockdir/tempfile
echo 'you can remove this directory, its a waybar temp file' > $lockdir/tempfile

update_state

if [ "$state" = "CONNECTED" ]; then
  ivpn disconnect
  update_state
  notify-send "VPN Toggle" "$state" -ae niri-script
else
  ivpn connect -protocol wireguard -f
  for i in {1..100}; do
    if [ "$state" = "CONNECTED" ]; then
      break
    fi
    update_state
    sleep 0.1s
  done
  info=$(ivpn status | grep \( | head -1)
  info=${info#*, }
  notify-send "VPN Toggle" "$state to $info" -ae niri-script
fi

pkill -RTMIN+8 waybar

exit
