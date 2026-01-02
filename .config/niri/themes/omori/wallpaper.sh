#!/usr/bin/env bash
swww-daemon --no-cache & disown
swww-daemon --no-cache --namespace blur & disown
sleep 0.2s
swww img $HOME/.config/niri/themes/omori/omori.png --transition-step 255 &
swww img --namespace blur $HOME/.config/niri/themes/omori/backdrop.png --transition-step 255 &
