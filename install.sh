#!/usr/bin/env bash
read -p "this will copy files into:
$HOME/.config/
and will also rm -rf:
$HOME/.config/alacritty
$HOME/.config/niri
$HOME/.config/rofi
$HOME/.config/waybar
$HOME/.config/swaync

i dont recommend you actually use this, i made this
for myself where i intend to always nuke my previous config files
please backup your current dots first

are you sure you want to run this (y/n): " confirm

if [ $confirm == "y" ]; then
    read -p "are you DEFINITELY sure (y/n): " confirm
else
    exit
fi

countdown=5

if [ $confirm == "y" ]; then
    while [ $countdown -gt 0 ]; do
        echo -ne "your current dots will be nuked in: $countdown\033[0K\r"
        sleep 1
        : $((countdown--))
    done

    rm -rf $HOME/.config/alacritty
    rm -rf $HOME/.config/niri
    rm -rf $HOME/.config/rofi
    rm -rf $HOME/.config/waybar
    rm -rf $HOME/.config/swaync

    cp -rv --preserve=links .config/* $HOME/.config

    niri msg action do-screen-transition --delay-ms 750

    swaync-client -R &
    swaync-client -rs
    $HOME/.config/niri/scripts/wallpaper.sh &
    pkill -x waybar ; waybar &

    echo
    echo done
fi
