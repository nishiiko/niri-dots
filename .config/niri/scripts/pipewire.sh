#!/usr/bin/env bash

## openrc supports user services now, i dont need to use this :>

# if ! grep -r systemd /sbin/init; then
#     pkill -x pipewire\|pipewire-pulse\|wireplumber
# 
#     pidwait -x pipewire\|pipewire-pulse\|wireplumber
#     
#     pipewire &
#     pipewire-pulse &
# 
#     sleep 1s
#     wireplumber &
# fi

paplay --volume=65535 $HOME/.config/niri/scripts/assets/heal.wav &
