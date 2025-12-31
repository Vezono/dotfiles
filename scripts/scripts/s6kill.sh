#!/bin/bash
s6-svscanctl -t /run/user/1000/s6/scandir
kill -KILL "$(pidof s6-svscan)"
kill -KILL "$(pidof s6-supervise)"
kill -KILL "$(pidof s6-log)"
rm -rf /run/user/1000/s6
