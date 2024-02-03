#!/bin/sh

choice=$(echo "Shutdown\nReboot\nExit" | dmenu -i -p "Select an action: ")

[[ -d $choice == "Shutdown" ]] && doas poweroff
[[ -d $choice == "Reboot" ]] && doas reboot
[[ -d $choice == "Exit" ]] && pkill dwm
