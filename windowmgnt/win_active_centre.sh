#!/bin/sh

wmctrl -r :ACTIVE: -b remove,maximized_vert
wmctrl -r :ACTIVE: -b remove,maximized_horz
wmctrl -r :ACTIVE: -e 0,440,0,2560,1440
wmctrl -r :ACTIVE: -b add,maximized_vert
