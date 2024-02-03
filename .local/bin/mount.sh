#!/bin/sh

uid=$(id -u)
gid=$(id -g)

usbdev=$(ls -l /sys/class/block/ | awk '/usb/ && /sd/ {print "/dev/"$9}')

if [ "$usbdev" ]
then
    selected=$( \
        lsblk -rno size,name,mountpoint $usbdev | \
        awk '($1!~"M" && $1!~"K") {printf "%s%8s%12s\n", $2, $1, $3}' | \
        dmenu -l 5 -i -p "USB Drives: " | awk '{print $1}' \
    )
    if grep -qs "$selected" /proc/mounts
    then
        sync
        doas umount /dev/$selected
        grep -qs /mnt/$selected /proc/mounts && doas rm -r /mnt/$selected
    else
        [ ! -d /mnt/$selected ] && doas mkdir /mnt/$selected
        doas mount -o uid=$uid,gid=$gid /dev/$selected /mnt/$selected
    fi
else
    echo "No drives connected" | dmenu -i -p "USB Drives: "
    exit
fi
