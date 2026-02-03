#!/bin/bash

set +e

# start portals
usertree u portals

nm-applet &
nextcloud &

