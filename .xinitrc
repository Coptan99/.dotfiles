#!/bin/sh

setxkbmap -layout us,ara -option grp:win_space_toggle,caps:escape,grp_led:caps
sxhkd &
xrandr --dpi 96
dunst &
xwallpaper --maximize ~/Pictures/wallpapers/0277.jpg
mpd &
pipewire &
dwmblocks &
brillo -S 2%
xcompmgr &
exec dwm
