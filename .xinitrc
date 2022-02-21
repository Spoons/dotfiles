#!/bin/zsh
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

export RESOLUTION="$(xrandr | awk -F'[ +x]' '/primary/ {print $5}')p"

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
	_PANEL_NAME="${1:-1440p}" #launch with default name if not set

	if [ -z "$(pgrep -x polybar)" ]; then
		for m in $(polybar --list-monitors | cut -d":" -f1); do
			MONITOR=$m polybar --reload "$_PANEL_NAME" &
		done
	else
		#        polybar-msg cmd restart
		pkill -9 polybar
	fi
}

launch_picom() {
	picom_resolution_config="$HOME/.config/picom/picom.$RESOLUTION.conf"
	if [ -f "$picom_resolution_config" ]; then
		picom --experimental-backends --config $picom_resolution_config &
	else
		picom --experimental-backends &
	fi
}

launch_cli() {
	if [ -n "$1" ]; then
		kitty --class "$1" --name "$1" "$1" &
	fi
}

# Settings based on hostname
case "$HOSTNAME" in
	iroh)
		RESOLUTION="1440p"
		nvidia-ffc -e
		set_wallpaper ~/media/images/wallpapers/lofi-swords.jpg
		;;
	hatsune)
		RESOLUTION="4k"
		POLYBAR_PANEL_NAME="4k"
		set_wallpaper ~/media/images/wallpapers/lofi-swords.jpg
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
dunst & # notifications
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets) #gnome secrets
launch_polybar "$POLYBAR_PANEL_NAME"
launch_picom
sxhkd -m -1 & #keyboard daemon
xidlehook --not-when-fullscreen --not-when-audio --timer 300 'betterlockscreen' '' &
pactl load-module module-switch-on-connect &
tachidesk &
redshift -l 35:-80 -t 5700:3600 -m randr &

# Settings based on hostname
case "$HOSTNAME" in
	iroh)
		alarm-clock-applet --hidden &
		ds4drv --hidraw --udp &
		mpDris2 &
	;;
	hatsune)
		batteryd &
		;;
esac

session=${1:-bspwm}
case $session in
	bspwm) exec bspwm ;;
	xfce | xfce4) exec startxfce4 ;;
esac
