#!/bin/sh
# vi: ft=sh

set -o errexit
set -o nounset

[ -r ~/.Xresources ] && xrdb ~/.Xresources

urxvtd -q -o -f

setxkbmap -layout us,cz -variant ",qwerty" -option "grp:caps_toggle" -option "grp_led:caps" &
xautolock -corners '0-0-' -time 5 &
xsetroot -solid black &

# Touchpad
xinput disable "SynPS/2 Synaptics TouchPad"
synclient TapButton1=1 TapButton2=3 TapButton3=2

gtk-redshift -l 50.08:14.43 &

# wheel emulation
xinput set-prop "TPPS/2 Elan TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 Elan TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 Elan TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 Elan TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5
# acceleration
xinput set-prop "TPPS/2 Elan TrackPoint" "Device Accel Constant Deceleration" 0.4

# Disable screensaver
xset -dpms
xset s off

# NetworkManager
ck-launch-session nm-applet &

echo "Starting i3 at $(date)" >> ~/.i3log
exec i3 -V -d all >> ~/.i3log
