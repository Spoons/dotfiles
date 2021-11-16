#! /bin/sh
# Author: Michael Ciociola
# License: GPLv3

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# system xresource merge
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

# user xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# system xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Assign hostname if not defined.
# Hostname variable is required by rest of dotfiles.
if [ -z "$HOSTNAME" ]; then
    export HOSTNAME="$(cat /proc/sys/kernel/hostname)"
fi

if [ -f "$HOME/.Xresources.$HOSTNAME" ]; then
    xrdb -merge ~/.Xresources.$HOSTNAME
fi

# X1 Carbon 7th Touchpad
if xinput | grep -q SYNA8004; then
    xinput --set-prop 'SYNA8004:00 06CB:CD8B Touchpad' \
        'libinput Accel Speed' 1
    xinput --set-prop 'SYNA8004:00 06CB:CD8B Touchpad' \
        'libinput Natural Scrolling Enabled' 1
    xinput --set-prop 'SYNA8004:00 06CB:CD8B Touchpad' \
        'libinput Tapping Enabled' 1
    xinput --set-prop 'TPPS/2 Elan TrackPoint' \
        'libinput Accel Speed' 1
fi

set_wallpaper() {
    feh --bg-fill "$1" &
}

launch_polybar() {
    _PANEL_NAME="${1:-default}" #launch with default name if not set
    polybar -c ~/.config/polybar/config "$_PANEL_NAME" &
}

# Settings based on hostname
case "$HOSTNAME" in
    iroh)
        ~/.screenlayout/single.sh
        set_wallpaper "$HOME/library/images/wallpapers/anime/1628445757130.jpg"
        nvffc -e
        ;;
    hatsune)
        POLYBAR_PANEL_NAME="4k"
        set_wallpaper "$HOME/local/wallpaper/wallhaven-ymz61d.jpg"
        xfce4-power-manager &
        ;;
esac


# Enable Firefox X flags, fix JAVA in tilers, and WINEFSYNC
export MOZ_USE_XINPUT2=1 MOZ_X11_EGL=1 MOZ_WEBRENDER=1 \
    _JAVA_AWT_WM_NONREPARENTING=1 WINEFSYNC=1


# Set keyboard layout to dvorak
setxkbmap dvorak

# Set blank time for monitor
xset s 180 180
xset dpms 180 180 180

# Autostart
ds4drv --hidraw --udp & #ps4 controller driver
dunst & # notifications
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets) #gnome secrets
launch_polybar "$POLYBAR_PANEL_NAME"
picom --experimental-backends --backend glx --xrender-sync-fence &
redshift -l 35:-80 -t 5700:3600 -m randr &
sxhkd -m -1 & #keyboard daemon
xidlehook --not-when-fullscreen --not-when-audio --timer 300 'lockscreen.sh' '' &


# launch bspwm by default if no argument is specified
session=${1:-bspwm}
case $session in
    bspwm) exec bspwm ;;
    xfce | xfce4) exec startxfce4 ;;
esac
