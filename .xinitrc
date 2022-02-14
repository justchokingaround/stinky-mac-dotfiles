#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# DWM Status
/home/ivan/.local/src/dwm-bar/dwm_bar.sh &

# Keyboard Layout
setxkbmap fr-latin9 &
xbindkeys &
sxhkd &

# Compositor
picom -f &

# Wallpaper
# nitrogen --restore &
~/.fehbg &

# Loop
while true; do
	dwm >/dev/null 2>&1
done

# Execute DWM
exec dwm
