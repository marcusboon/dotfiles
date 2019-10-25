#!/bin/sh

wmctrl -r :ACTIVE: -b remove,maximized_vert
wmctrl -r :ACTIVE: -b remove,maximized_horz
wmctrl -r :ACTIVE: -e 0,0,0,2292,1440
wmctrl -r :ACTIVE: -b add,maximized_vert
