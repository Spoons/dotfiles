zstyle ':z4h:' auto-update      'no'
zstyle ':z4h:' auto-update-days '28'
zstyle ':z4h:' prompt-at-bottom 'yes'
zstyle ':z4h:bindkey' keyboard  'pc'
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:fzf-complete' recurse-dirs 'no'
zstyle ':z4h:direnv'         enable 'no'
zstyle ':z4h:direnv:success' notify 'yes'
zstyle ':z4h:ssh:*'                   enable 'no'
zstyle ':z4h:ssh:*-office'      enable 'yes'
zstyle ':z4h:ssh:*-office' send-extra-files '~/.doom.d/config.el' '~/.doom.d/init.el' '~/.doom.d/packages.el' 

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-/home/miffi/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-/home/miffi/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-/home/miffi/.local/share}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/share/local:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share}"

export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export LESSKEY="${XDG_CONFIG_HOME}/less/lesskey"
export STACK_ROOT="${XDG_DATA_HOME}/stack"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# set hostname var if not set
if (( ! ${+HOSTNAME} )); then
    export HOSTNAME="$(cat /proc/sys/kernel/hostname)"
fi

# Export environment variables.
export GPG_TTY=$TTY
export HISTSIZE=922337203685477580
export KEYTIMEOUT=1
export SAVEHIST="$HISTSIZE"

# zsh
export ZDIR="$HOME/.zsh"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"

# Applications
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -nw"
export BROWSER="firefox"
export FILEMANAGER="ranger"
export PDFREADER="zathura"
export TERMINAL="kitty"
# System
export LIBVIRT_DEFAULT_URI="qemu:///system"
# Nvim
export VIMINIT="source $HOME/.config/nvim/init.lua"
# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1
# Unity / Mono
export FrameworkPathOverride=/lib/mono/4.8-api
# Application Data
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
# UI
export XCURSOR_SIZE="32"
export QT_QPA_PLATFORMTHEME=gtk3
# Games
export RMM_PATH="~/games/rimworld"

AGENT_SOCK=$(gpgconf --list-dirs | grep agent-socket | cut -d : -f 2)

if [[ ! -S $AGENT_SOCK ]]; then
  gpg-agent --daemon --use-standard-socket &>/dev/null
fi
export GPG_TTY=$TTY

# Set SSH to use gpg-agent if it's enabled
GNUPGCONFIG="${GNUPGHOME:-"$HOME/.gnupg"}/gpg-agent.conf"
if [[ -r $GNUPGCONFIG ]] && command grep -q enable-ssh-support "$GNUPGCONFIG"; then
  export SSH_AUTH_SOCK="$AGENT_SOCK.ssh"
  unset SSH_AGENT_PID
fi

# Start ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

zstyle ':z4h:' start-tmux no

z4h install ohmyzsh/ohmyzsh || return
z4h install agkozak/zsh-z || return
z4h install djui/alias-tips || return

if [ ! -e "$HOME/.emacs.d/bin/doom" ]; then
  if [ -d "$HOME/.emacs.d" ]; then
    print "Moving .emacs.d folder to emacs-$(date --iso)"
    mv $HOME/.emacs.d "$HOME/emacs-$(date --iso)"
  fi
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
fi

z4h load agkozak/zsh-z
z4h load djui/alias-tips
z4h load ohmyzsh/ohmyzsh/plugins/copyfile

z4h init || return

# Extend PATH.
path=(~/.pbin ~/.bin ~/.bin/shims $path)


# Source additional local files if they exist.
z4h source ~/.env.zsh

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab # undo the last command line change
z4h bindkey redo Alt+/            # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt autocd
setopt auto_pushd           # Push the current directory visited on the stack.

# Load zsh plugins
for f ($ZDIR/load.d/**/*.zsh(N.))  . $f

alias kitty_pair="bluetoothctl power on ; bluetoothctl connect 28:11:A5:DD:41:80"
alias iwscan="iwctl station wlan0 scan ; iwctl station wlan0 get-networks"
alias iwc="iwctl station wlan0 connect"
alias mpv="mpv --hwdec=auto"

_nh() {
    nohup "$@" >/dev/null 2>&1 &
}
alias nh="_nh"
alias yay="paru"
alias ara="paru"
alias dps='docker ps --format "table {{ .ID }}\t{{.Names}}\t{{.Status}}" | awk '\''NR == 1; NR > 1 {print $0 | "sort -k2"}'\'

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

alias swapfiles='fd "(\.sw[klmnop]|\.bak|~)$"'
alias focus='pkill -9 Discord && pkill -9 discord && pkill -9 electron && pkill -9 signal'
