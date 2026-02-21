#!/usr/bin/env bash
sleep 0.1s
visible=false

until $visible; do
  pkill -x waybar
  waybar &
  for i in {1..30}; do
    sleep 0.1s
    if niri msg --json layers \
      | jq '.[].namespace' \
      | grep waybar; then
      visible=true
      break 1
    fi
  done
  continue
done

pkill -RTMIN+8 waybar
