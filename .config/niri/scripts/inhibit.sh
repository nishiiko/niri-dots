#!/usr/bin/env bash

streams=0

while read -r line; do

  if echo $line | grep "Closed"; then
    ((streams--))
  elif echo $line | grep "PipeWireStreamAdded"; then
    ((streams++))
  fi
  
  if (($streams > 0)); then
    swaync-client --inhibitor-add "xdg-desktop-portal-gnome"
    continue
  fi

  swaync-client --inhibitor-remove "xdg-desktop-portal-gnome"

done < <(dbus-monitor --session "sender='org.gnome.Mutter.ScreenCast',type='signal'" | grep --line-buffered member)
