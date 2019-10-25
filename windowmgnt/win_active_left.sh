#!/bin/sh

# get width of screen and height of screen
SCREEN_WIDTH=$(xwininfo -root | awk '$1=="Width:" {print $2}')
SCREEN_HEIGHT=$(xwininfo -root | awk '$1=="Height:" {print $2}')

# new width and height
X=0
Y=0
W=$(($SCREEN_WIDTH * 2 / 3))
H=$(($SCREEN_HEIGHT))

wmctrl -r :ACTIVE: -b remove,maximized_vert
wmctrl -r :ACTIVE: -b remove,maximized_horz
wmctrl -r :ACTIVE: -e 0,$X,$Y,$W,$H
wmctrl -r :ACTIVE: -b add,maximized_vert
