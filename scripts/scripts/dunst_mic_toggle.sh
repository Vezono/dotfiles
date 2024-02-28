#!/bin/bash

getIcon() {
    if [ "$1" -eq 0 ]; then
        echo "~/.icons/tmp/display-brightness-off-symbolic.svg"
    elif [ "$1" -lt 33 ]; then
        echo "~/.icons/tmp/display-brightness-low-symbolic.svg"
    elif [ "$1" -lt 66 ]; then
        echo "~/.icons/tmp/display-brightness-medium-symbolic.svg"
    else
        echo "~/.icons/tmp/display-brightness-high-symbolic.svg"
    fi

}

pamixer --source alsa_input.pci-0000_04_00.6.analog-stereo -t
current=$(pamixer --source alsa_input.pci-0000_04_00.6.analog-stereo --get-volume-human|head -c -2)
truncated=$(echo "$current" | cut -d '.' -f1)
if [ "$current" == "mute" ]; then
    current=0
    truncated=0
fi
dunstify "Гучність на ${truncated}%" -i $(getIcon "$truncated") -a "Гучність Мікрофону" -u normal -h "int:value:$current" -h string:x-dunst-stack-tag:backlight
