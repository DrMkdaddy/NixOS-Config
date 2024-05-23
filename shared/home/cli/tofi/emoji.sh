#!/bin/bash
chosn=$(cut -d ';' -f1 ${./emoji} | tofi | sed "s/ .*//")
[ -z "$chosen" ] && exit
if [ -n "$1" ]; then
    wtype "$chosen"
else
    printf "$chosen" | wl-copy
    notify-send "'$chosen' copied to clipboard." &
fi
