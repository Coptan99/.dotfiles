#!/bin/sh

setxkbmap -layout us,ara -option grp:win_space_toggle,caps:escape,grp_led:caps
xwallpaper --stretch Pictures/wallpapers/0040.jpg
sxhkd &
dunst &
pipewire &
mpd &
dwmblocks &
xcompmgr &
xbacklight -set 5
xautolock -time 10 -locker slock &
dbus-update-activation-environment --all
dbus-launch ssh-agent dwm
