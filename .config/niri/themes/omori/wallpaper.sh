#!/usr/bin/env bash
awww-daemon --no-cache & disown
awww-daemon --no-cache --namespace blur & disown
sleep 0.2s
awww img $HOME/.config/niri/themes/omori/omori.png --transition-step 255 &
awww img --namespace blur $HOME/.config/niri/themes/omori/backdrop.png --transition-step 255 &
