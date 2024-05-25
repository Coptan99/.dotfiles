#!/bin/sh

setxkbmap -layout us,ara -option grp:win_space_toggle,caps:escape,grp_led:caps
sxhkd &
dunst &
pipewire &
mpd &
dwmblocks &
xbacklight -set 5
xautolock -time 10 -locker slock &
dbus-update-activation-environment --all
dbus-launch ssh-agent dwm
