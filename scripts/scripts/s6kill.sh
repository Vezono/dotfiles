#!/bin/bash
killall -q s6-svscan
killall -q s6-supervise
killall -q s6-log
#s6-svscanctl -t /run/user/1000/s6/scandir
