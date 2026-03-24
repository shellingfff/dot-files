#!/bin/zsh

while true; do
	xsetroot -name  $(cat /sys/class/power_supply/BAT0/capacity)
	sleep 1s
done

