#!/bin/sh
# vi: set ft=sh

set -o errexit
set -o nounset

[ -r ~/.Xresources ] && xrdb ~/.Xresources

urxvtd -q -o -f

setxkbmap -layout us,cz -variant ",qwerty" -option "grp:caps_toggle" &
xautolock -corners '0-0-' -time 5 &
xsetroot -solid black &

# Disable annoying inputs
xinput disable "SynPS/2 Synaptics TouchPad"

# FIXME - wrong (generic) model on X1 gen 5
# trackpoint wheel emulation
xinput set-prop "PS/2 Generic Mouse" "Evdev Wheel Emulation" 1
xinput set-prop "PS/2 Generic Mouse" "Evdev Wheel Emulation Button" 2
xinput set-prop "PS/2 Generic Mouse" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "PS/2 Generic Mouse" "Evdev Wheel Emulation Axes" 6 7 4 5
# trackpoint sensitivity
xinput set-prop "PS/2 Generic Mouse" "Device Accel Constant Deceleration" 1

# Disable screensaver
xset -dpms
xset s off

# NetworkManager
ck-launch-session nm-applet &

echo "Starting i3 at $(date)" >> ~/.i3log
exec i3 -V -d all >> ~/.i3log
