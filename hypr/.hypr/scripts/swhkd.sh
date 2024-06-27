#!/bin/bash
killall -q sxhkd
swhks & pkexec swhkd -c ~/.hypr/swhkdrc
