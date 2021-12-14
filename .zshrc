zstyle ':z4h:' auto-update      'no'
zstyle ':z4h:' auto-update-days '28'
zstyle ':z4h:' prompt-at-bottom 'yes'
zstyle ':z4h:bindkey' keyboard  'pc'
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:fzf-complete' recurse-dirs 'no'
zstyle ':z4h:direnv'         enable 'yes'
zstyle ':z4h:direnv:success' notify 'yes'
zstyle ':z4h:ssh:*'                   enable 'no'
zstyle ':z4h:ssh:*-office'      enable 'yes'
zstyle ':z4h:ssh:*-office' send-extra-files '~/.doom.d/config.el' '~/.doom.d/init.el' '~/.doom.d/packages.el' 


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

if [[ -z $DISPLAY && XDG_VTNR -eq 1 ]]; then
  zstyle ':z4h:' start-tmux no
fi


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
path=(~/.pbin ~/.bin $path)

# set hostname var if not set
if (( ${+HOSTNAME} )); then
    export HOSTNAME="$(cat /proc/sys/kernel/hostname)"
fi

# Export environment variables.
export GPG_TTY=$TTY
export HISTSIZE=922337203685477580
export KEYTIMEOUT=1
export SAVEHIST="$HISTSIZE"

export ZDIR="$HOME/.zsh"
export HISTFILE="$HOME/.zhistory"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"

# Applications
export EDITOR="emacs -nw"
export BROWSER="firefox"
export FILEMANAGER="ranger"
export PDFREADER="zathura"
export TERMINAL="kitty"

# XDG Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# System
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Nvim
export VIMINIT="source $HOME/.config/nvim/init.vim"

# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export _JAVA_AWT_WM_NONREPARENTING=1

# Unity / Mono
export FrameworkPathOverride=/lib/mono/4.8-api

# Application Data
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# UI
export XCURSOR_SIZE="32"
export QT_QPA_PLATFORMTHEME=gtk3

# Games
export RMM_PATH="~/games/rimworld"

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
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
setopt autocd
setopt auto_pushd           # Push the current directory visited on the stack.
setopt glob_complete
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt pushd_ignore_dups    # Do not store duplicates in the stack.
setopt pushd_silent         # Do not print the directory stack after pushd or popd.


# Load zsh plugins
for f ($ZDIR/load.d/**/*.zsh(N.))  . $f



if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
 exec startx &> ~/.cache/Xoutput
fi
