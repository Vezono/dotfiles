#!/bin/bash

current=$(pamixer --source alsa_input.pci-0000_04_00.6.analog-stereo --get-volume-human|head -c -2)
emoji="%{F#61C766}󰍬%{F-}"
if [ "$current" == "mute" ]; then
    emoji="%{F#EC7875}󰍭%{F-}"
fi

echo $emoji
