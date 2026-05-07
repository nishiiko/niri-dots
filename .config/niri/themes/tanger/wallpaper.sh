#!/usr/bin/env bash

awww-daemon --no-cache & disown
awww-daemon --no-cache --namespace blur & disown
sleep 0.2s
awww img $HOME/.config/niri/themes/tanger/tanger.png --transition-step 255 &
awww img --namespace blur $HOME/.config/niri/themes/tanger/backdrop.png --transition-step 255 &
