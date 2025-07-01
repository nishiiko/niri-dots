#!/bin/bash

until pgrep -x swww-daemon; do
    swww-daemon --no-cache &
    sleep 0.2s
done

swaybg --image $HOME/Pictures/Wallpapers/omori_blur.png &
swww img $HOME/Pictures/Wallpapers/omori.png --transition-type grow --transition-duration 3 &
