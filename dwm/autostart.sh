#!/bin/zsh

function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}
#run "xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal"
#run "xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off"
#run xrandr --output eDP-1 --primary --mode 1368x768 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off
#run xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#run xrandr --output DVI-I-0 --right-of HDMI-0 --auto
#run xrandr --output DVI-1 --right-of DVI-0 --auto
#run xrandr --output DVI-D-1 --right-of DVI-I-1 --auto
#run xrandr --output HDMI2 --right-of HDMI1 --auto
#autorandr horizontal
run xrandr --output HDMI-1 --mode "2048x1280" --scale 1.0x1.0

sxhkd -c ~/.config/dwm/sxhkd/sxhkdrc &
run "nm-applet"
#xset dpms 180 &
#xss-lock  -- slock  -n &
#xss-lock --transfer-sleep-lock -- i3lock --nofork &
#run "xfce4-power-manager"
#powerkit &
#run "blueberry-tray" 
#run "blueman-applet"
#run "/usr/lib/xfce4/notifyd/xfce4-notifyd" 
#run "/usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd"

#run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" 
#picom -b  --config ~/.config/dwm/picom.conf
picom -b
run "numlockx on" 
#run "mate-volume-control-status-icon"
#run "slstatus"
~/.config/dwm/scripts/bar.sh &
feh --bg-fill ~/.config/dwm/bg.png &
#ibus-daemon -rxRd
#fcitx5 -d
#
#run "mate-mouse-properties"
#run "/usr/bin/mate-settings-daemon"
#run ~/.config/polybar/launch.sh &
#run xfce4-mouse-settings

