#!/bin/sh

CONFIG_FILES="config style.css"

trap "killall waybar" EXIT

while true; do
    waybar -c config -s style.css &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done
