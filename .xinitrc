dbus-update-activation-environment --all
! pidof -s pulseaudio >/dev/null 2>&1 && setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1
setxkbmap -layout us,ara -option grp:alts_toggle,caps:escape,grp_led:caps
sxhkd &
dwmblocks &
dunst &
dwm
