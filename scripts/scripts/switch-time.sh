#!/bin/bash
touch /run/user/1000/current-time-switch

current=$(cat /run/user/1000/current-time-switch)

if [[ "$current" == "Europe/Kiev" ]]; then
    echo Canada/Eastern > /run/user/1000/current-time-switch
else
    echo Europe/Kiev > /run/user/1000/current-time-switch
fi

cat /run/user/1000/current-time-switch
