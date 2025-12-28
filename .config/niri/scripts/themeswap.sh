#!/usr/bin/env bash

cd $HOME/.config/niri/themes/
theme=non-existent-theme

until [ -d $PWD/$theme ]; do

read -p "select theme from:
$(ls)
> " theme
  
if [ ! -d $PWD/$theme ]; then
  echo bruh
fi

done

echo ok

niri msg action do-screen-transition --delay-ms 750

ln -sfrv $PWD/$theme/alacritty/colours.toml $HOME/.config/alacritty/
ln -sfrv $PWD/$theme/niri/decorations.kdl $HOME/.config/niri/config.kdl.d/
ln -sfrv $PWD/$theme/rofi/background.png $HOME/.config/rofi/
ln -sfrv $PWD/$theme/rofi/colours.rasi $HOME/.config/rofi/
ln -sfrv $PWD/$theme/swaync/colours.css $HOME/.config/swaync/
ln -sfrv $PWD/$theme/waybar/colours.css $HOME/.config/waybar/
ln -sfrv $PWD/$theme/wallpaper.sh $HOME/.config/niri/scripts/wallpaper.sh

swaync-client -R &
swaync-client -rs &
$HOME/.config/niri/scripts/wallpaper.sh &
pkill -x waybar ; waybar &
