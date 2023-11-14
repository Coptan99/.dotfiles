#!/bin/sh

export BROWSER="firefox"
export TERMINAL="st"
export PATH="$PATH:${$(find ~/.local/bin -maxdepth 1 -type d -printf %p:)%%:}"
export MANPAGER="nvim +Man!"
export EDITOR="nvim"

[[ ! $DISPLAY && $(tty) = "/dev/tty1" ]] && startx
