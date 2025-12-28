#!/usr/bin/env bash

swww-daemon --no-cache & disown
sleep 0.2s
swaybg -i $HOME/.config/niri/themes/tanger/backdrop.png &
swww img $HOME/.config/niri/themes/tanger/tanger.png --transition-step 255 &
