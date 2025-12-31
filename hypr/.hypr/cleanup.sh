#!/bin/sh
/home/vezono/scripts/s6kill.sh
kill $(pidof dbus-daemon)
