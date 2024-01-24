#!/usr/bin/bash

choice=$(echo -e "Shutdown\nReboot\nExit" | dmenu -p "Select an action: ")

case $choice in
    Shutdown)
        doas poweroff ;;
    Reboot)
        doas reboot ;;
    Exit)
        pkill dwm ;;
esac
