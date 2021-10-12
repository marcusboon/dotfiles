#!/bin/sh

if [ -f ~/.dotfiles/windowmgnt/screenvars.conf ]; then
    . ~/.dotfiles/windowmgnt/screenvars.conf
fi

# new width and height
X=0
Y=0
W=$(($SCREEN_WIDTH / 3))
H=$(($SCREEN_HEIGHT))

wmctrl -r :ACTIVE: -b remove,maximized_vert
wmctrl -r :ACTIVE: -b remove,maximized_horz
wmctrl -r :ACTIVE: -e 0,$X,$Y,$W,$H
wmctrl -r :ACTIVE: -b add,maximized_vert
