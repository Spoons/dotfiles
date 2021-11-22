#!/usr/local/bin/env zsh
# Name: zshrc
# Author: Michael Ciociola
# License: GPLv3



_comp_options+=(globdots)
autoload -U compinit; compinit
export HISTSIZE=922337203685477580
export KEYTIMEOUT=1
export SAVEHIST="$HISTSIZE"
setopt AUTOCD
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt GLOB_COMPLETE
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

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
export PATH="$HOME/.local/bin:$HOME/.pbin:$HOME/.bin:$PATH"
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

export CASE_SENSITIVE=false
export HYPHEN_INSENSITIVE=true


# set hostname var if not set
if [ -z "$HOSTNAME" ]; then
    export HOSTNAME="$(cat /proc/sys/kernel/hostname)"
fi

# install p10k if not installed
P10KDIR="$HOME/.powerlevel10k"
if [[ ! -d "$P10KDIR" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
fi

# install fzf if not installed
FZFDIR="$HOME/.fzf"
if [[ ! -d "$FZFDIR" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZFDIR"
    "$FZFDIR/install"
fi

# load fzf if it exists
if [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
fi

# stores completions cache
[[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p "$ZSH_CACHE_DIR"
# personal information
[[ -f "$ZDIR/zinfo"      ]] && . "$ZDIR/zinfo"

# Load zsh plugins
for f ($ZDIR/load.d/**/*.zsh(N.))  . $f

if [[ -x "$ZDIR/host.d/$HOSTNAME.zsh" ]]; then
    . "$ZDIR/host.d/$HOSTNAME.zsh"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
