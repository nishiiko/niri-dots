#!/bin/bash

until pgrep -x swww-daemon; do
    swww-daemon --no-cache &
done

swww img $HOME/Pictures/Wallpapers/omori.png --transition-type grow --transition-duration 3
