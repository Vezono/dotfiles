#!/bin/bash

current=$(pamixer --source alsa_input.pci-0000_04_00.6.analog-stereo --get-volume-human|head -c -2)
emoji="<span color='#61C766'>​<b>󰍬</b></span>"
if [ "$current" == "mute" ]; then
    emoji="<span color='#EC7875'>​<b>󰍭</b></span>"
fi

echo $emoji
