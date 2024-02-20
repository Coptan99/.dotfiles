#!/bin/sh

setxkbmap -layout us,ara -option grp:win_space_toggle,caps:escape,grp_led:caps
sxhkd &
xrandr --dpi 96
dunst &
mpd &
pipewire &
dwmblocks &
brillo -S 2%
dbus-update-activation-environment --all
ssh-agent dwm
