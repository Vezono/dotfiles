#!/bin/bash

set +e

# start portals
usertree u portals

XDG_MENU_PREFIX=arch- kbuildsycoca6

nextcloud &

