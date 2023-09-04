#!/bin/bash
run nm-applet &
run volumeicon &
swaybg -m fill -i $HOME/.config/hypr/bg/minimal.png &
#fcitx5 -d
#ibus-daemon -x -d
sg no-net fcitx &
