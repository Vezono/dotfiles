#!/bin/bash

# Set limit to shell argument
batteryLimit=$1

if [[ "$batteryLimit" == "" ]]; then
   batteryLevel=$(acpi | grep -v 'unavailable' | cut -d ' ' -f 4 | tr -d '%|,| ')
   charging=$(acpi | grep -v 'unavailable' | cut -d ' ' -f 3 | tr -d ',| ')
   time=$(acpi | grep -v 'unavailable' | cut -d ' ' -f 5)
   notify-send -a "Інформація про живлення" -u normal "Заряд батареї - ${batteryLevel}%. Залишилось $time." -i battery -h string:x-dunst-stack-tag:battery
   exit 0
fi

while true; do
 # Get the current battery level with acpi
 batteryLevel=$(acpi | grep -v 'unavailable' | cut -d ' ' -f 4 | tr -d '%|,| ')
 charging=$(acpi | grep -v 'unavailable' | cut -d ' ' -f 3 | tr -d ',| ')
 time=$(acpi | grep -v 'unavailable' | cut -d ' ' -f 5)

 if [[ "$batteryLevel" -le "$batteryLimit" ]] && [[ "$charging" == "Discharging" ]]; then
     notify-send -a "Попередження про живлення" -u critical "Заряд батареї - ${batteryLevel}%. Залишилось $time." -i battery -h string:x-dunst-stack-tag:battery
 fi
 sleep 1s
done
