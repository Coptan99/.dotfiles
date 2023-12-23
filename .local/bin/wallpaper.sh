#!/usr/bin/env bash

# Path to your wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Select a random wallpaper from the directory
WALLPAPER=$(ls $WALLPAPER_DIR | shuf -n 1)

# Set the wallpaper using feh
feh --bg-fill "$WALLPAPER_DIR/$WALLPAPER"
