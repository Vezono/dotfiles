#!/bin/bash
#  ____  _             _    __        __          _                 
# / ___|| |_ __ _ _ __| |_  \ \      / /_ _ _   _| |__   __ _ _ __  
# \___ \| __/ _` | '__| __|  \ \ /\ / / _` | | | | '_ \ / _` | '__| 
#  ___) | || (_| | |  | |_    \ V  V / (_| | |_| | |_) | (_| | |    
# |____/ \__\__,_|_|   \__|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|    
#                                           |___/                   
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

# Check if waybar-disabled file exists
if [ -f $HOME/.cache/waybar-disabled ] ;then 
    killall waybar
    pkill waybar
    exit 1 
fi

# ----------------------------------------------------- 
# Quit all running waybar instances
# ----------------------------------------------------- 
killall waybar
pkill waybar
sleep 0.2
# ----------------------------------------------------- Get current theme information from .cache/.themestyle.sh ----------------------------------------------------- if [ -f 


# ----------------------------------------------------- 
# Loading the configuration
# ----------------------------------------------------- 
config_file="config"
style_file="style.css"

waybar -c ~/.hypr/waybar/$config_file -s ~/.hypr/waybar/$style_file &
