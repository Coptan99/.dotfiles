#!/bin/sh

choice=$(printf "Shutdown\nReboot\nSuspend\nExit" | dmenu -i -p "Select an action: ")

case "$choice" in
    "Shutdown") doas poweroff
     ;;
    "Suspend") systemctl suspend
     ;;
    "Reboot") doas reboot
     ;;
    "Exit") pkill dwm
     ;;
    *) exit 1;;
esac
