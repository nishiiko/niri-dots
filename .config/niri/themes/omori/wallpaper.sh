#!/usr/bin/env bash
swww-daemon --no-cache & disown
sleep 0.2s
swaybg -i $HOME/.config/niri/themes/omori/backdrop.png &
swww img $HOME/.config/niri/themes/omori/omori.png --transition-step 255 &
