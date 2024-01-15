#!/bin/sh

setxkbmap -layout us,ara -option grp:win_space_toggle,caps:escape,grp_led:caps
sxhkd &
dunst &
feh --bg-fill ~/Pictures/wallpapers/0277.jpg
pipewire &
dwmblocks &
brillo -S 2%
xcompmgr &
exec i3
