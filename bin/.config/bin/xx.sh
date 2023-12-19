#!/bin/bash

if xrandr --listactivemonitors| grep -i "monitors: 2";then
	xrandr --output LVDS --off
elif xrandr --listactivemonitors | grep -i "monitors: 1";then 
	xrandr --output LVDS --auto
fi
