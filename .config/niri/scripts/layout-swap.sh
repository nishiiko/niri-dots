#!/usr/bin/env bash
niri msg action switch-layout "next"
layout=$(niri msg --json keyboard-layouts | jq -r '.names.[.current_idx]')
ln -sf $HOME/.config/niri/extras/layouts/"$layout" $HOME/.config/niri/config.kdl.d/keybinds.kdl
notify-send "Switched Layout" "Current layout: $layout" -ae niri-script
