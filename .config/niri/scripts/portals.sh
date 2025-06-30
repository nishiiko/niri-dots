#!/usr/bin/env bash

if ! grep -r systemd /sbin/init; then
    sleep 1
    pkill -f xdg-desktop-portal
    /usr/lib*/xdg-desktop-portal-gnome &
    /usr/lib*/xdg-desktop-portal-gtk &
fi
