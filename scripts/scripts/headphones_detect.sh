#!/bin/bash

#HEADPHONES="ATH-SR30BT"
HEADPHONES="s Rhapsody"

current=$(echo $(pamixer --get-default-sink | tail -n 1 | tail -c 12 | head -c 10))
if [ "$current" == "$HEADPHONES" ]; then
    emoji="%{F#61C766}󰋋%{F-}"
fi

echo $emoji
