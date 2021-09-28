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

# Settings based on hostname
case "$HOSTNAME" in
    iroh)
        #~/.screenlayout/dual.sh
        WALLPAPER="$HOME/library/images/wallpapers/the_neon_shallows_by_kawitt_ddm6tx0.png"
        POLYBAR_PANEL="top-1440"
        nvidia-ffc -e
        ;;
    hatsune)
        WALLPAPER="$HOME/local/wallpaper/wallhaven-ymz61d.jpg"
        POLYBAR_PANEL="top-4k"
        PICOM_CONFIG="/etc/xdg/picom.conf"
        xfce4-power-manager &
        ;;
esac


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

function _start {
    pgrep -x "$1" >/dev/null || pkill "$1"
    if [ ! $? -eq 1  ] and [ ! $? -eq 2 ]; then
        echo "Failed to kill $1\n"
    fi
    eval "$1" &
}

# Enable Firefox X flags, fix JAVA in tilers, and WINEFSYNC
export MOZ_USE_XINPUT2=1 MOZ_X11_EGL=1 MOZ_WEBRENDER=1 \
    _JAVA_AWT_WM_NONREPARENTING=1 WINEFSYNC=1

setxkbmap dvorak
feh --bg-scale "$WALLPAPER"
[ -f "$HOME/.Xresources.$HOSTNAME" ] &&
    xrdb -merge ~/.Xresources.$HOSTNAME
xsetroot -cursor_name left_ptr &

# Autostart
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
_start "picom --experimental-backends --backend glx --xrender-sync-fence --config ${PICOM_CONFIG:=~/.config/picom/picom.conf}"
_start "redshift -l 35:-80 -t 5700:3600 -m randr"
_start "sleep 2 && polybar -c ~/.config/polybar/config ${POLYBAR_PANEL:=top}"
_start "sxhkd -m -1"
_start "xidlehook --not-when-fullscreen --not-when-audio --timer 180 'betterlockscreen -l dim -t' ''"
_start "ds4drv --hidraw --udp"


session=${1:-bspwm}
case $session in
    bspwm)
        dunst &
        kitty &
        exec bspwm
        ;;
    xfce | xfce4)
        exec startxfce4
        ;;
    *) exec $1 ;;
esac
