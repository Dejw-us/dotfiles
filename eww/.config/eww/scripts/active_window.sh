#!/bin/bash

previous_window=""
i=0

while true; do
    current_window=$(hyprctl activewindow -j | jq -r '.address')
    if [[ "$current_window" != "$previous_window" ]]; then
        notify-send "Focus changed to $current_window"
        # You can trigger Eww here:
        echo "$current_window"
        echo "$i"
        if [ "$i" == 1 ]; then
          echo "true"
          # exit 0
        fi
        previous_window="$current_window"
        i=1
    fi
    sleep 0.1
done
