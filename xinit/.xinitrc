!/bin/bash

if xrandr --listactivemonitors| grep -i "monitors: 2";then
	xrandr --output LVDS --off
	xrandr --output VGA-0 --gamma 1.0:0.95:0.8
elif xrandr --listactivemonitors | grep -i "monitors: 1";then 
	xrandr --output LVDS --auto
	xrandr --output LVDS --gamma 1.0:0.95:0.8
fi
compton &
slstatus &
nitrogen --restore &
pulseaudio --start
exec i3
