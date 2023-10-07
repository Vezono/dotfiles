#!/bin/bash

subinc=1
subchange=1 #$(echo "1 / $subinc" | bc -l)
delay=0.001
opt=""


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


if [ "$1" == "inc" ]; then
    opt="-i"
else
    opt="-d"
fi


for i in $(seq $2); do
    current=$(pamixer --source alsa_input.pci-0000_04_00.6.analog-stereo --get-volume-human|head -c -2)
    echo "$current - current"
    truncated=$(echo "$current" | cut -d '.' -f1)

    if (( $(echo "$current==0" | bc -l) )) && [ "$opt" == "-U" ]; then
        exit 0;
    elif (( $(echo "$current==100" | bc -l) )) && [ "$opt" == "-A"  ]; then
        exit 0;
    fi

    for i in $(seq $subinc); do
        echo "Change - $subchange"
        pamixer --source alsa_input.pci-0000_04_00.6.analog-stereo $opt "$subchange"
        sleep "$delay"
    done
        
    current=$(pamixer --source alsa_input.pci-0000_04_00.6.analog-stereo --get-volume-human|head -c -2)
    truncated=$(echo "$current" | cut -d '.' -f1)

    
    dunstify "Гучність на ${truncated}%" -i $(getIcon "$truncated") -a "Гучність Мікрофону" -u normal -h "int:value:$current" -h string:x-dunst-stack-tag:backlight
done
