#!/usr/bin/env bash

if ! grep -r systemd /sbin/init; then
    pkill -x pipewire\|pipewire-pulse\|wireplumber

    pidwait -x pipewire\|pipewire-pulse\|wireplumber
    
    pipewire &
    pipewire-pulse &

    sleep 1s
    wireplumber &
fi
sleep 0.5s
paplay --volume=65535 $HOME/.config/niri/scripts/assets/heal.wav &
