#!/bin/bash

h=$(cat ~/.ssh/known_hosts | awk '
{ print $1 } ' | awk -F\, '
{ print $1 } ' | sort -u | dmenu )

gnome-terminal -x sh -c "ssh $h" -e ssh $h
~
