#!/bin/sh

choice=$(echo "Shutdown\nReboot\nExit" | dmenu -i -p "Select an action: ")

if [[ "$choice" == "Shutdown" ]]; then
    doas poweroff
elif [[ "$choice" == "Reboot" ]]; then
    doas reboot
elif [[ "$choice" == "Exit" ]]; then
    pkill dwm
fi
