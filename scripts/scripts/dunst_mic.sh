#!/bin/bash

subinc=1
subchange=1 #$(echo "1 / $subinc" | bc -l)
delay=0.001
opt=""

mic_source="alsa_input.pci-0000_04_00.6.analog-stereo"

if [ "$1" == "inc" ]; then
    opt="-i"
else
    opt="-d"
fi


for i in $(seq $2); do
    current=$(pamixer --source $mic_source --get-volume-human | head -c -2)
    truncated=$(echo "$current" | cut -d '.' -f1)

    if (( $(echo "$current==0" | bc -l) )) && [ "$opt" == "-U" ]; then
        exit 0;
    elif (( $(echo "$current==100" | bc -l) )) && [ "$opt" == "-A"  ]; then
        exit 0;
    fi

    for i in $(seq $subinc); do
        echo "Change - $subchange"
        pamixer --source $mic_source $opt "$subchange"
        sleep "$delay"
    done
        
    current=$(pamixer --source $mic_source --get-volume-human|head -c -2)
    truncated=$(echo "$current" | cut -d '.' -f1)

    
    dunstify "Гучність на ${truncated}%" -i "~/.icons/tmp/display-brightness-high-symbolic.svg" -a "Гучність Мікрофону" -u normal -h "int:value:$current" -h string:x-dunst-stack-tag:backlight
done
