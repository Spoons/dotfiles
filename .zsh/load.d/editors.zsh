#!/usr/bin/env zsh

# Emacs
if (( $+commands[emacs] )); then
    alias e='emacs -nw'
    alias eg='emacs'
    alias ue='USER_EMACS_DIRECTORY=$PWD e'
    alias uew='USER_EMACS_DIRECTORY=$PWD ew'

    if [[ "$TERM" == "xterm-kitty" ]] || [[ "$TERM" == "tmux-256color" ]]; then
        alias emacs="TERM=kitty-direct emacs"
    fi
    if [[ -d "$HOME/.emacs.d/bin" ]]; then
        PATH="$PATH:$HOME/.emacs.d/bin"
    fi
fi


if (( $+commands[emacsclient] )); then
    alias ec='emacsclient --alternate-editor= -nw'
    alias ecw='emacsclient --alternate-editor='
    if [[ "$TERM" == "xterm-kitty" ]] || [[ "$TERM" == "tmux-256color" ]]; then
        alias emacsclient="TERM=kitty-direct emacsclient"
    fi
    export EDITOR='emacsclient --alternate-editor= -nw'
fi


#### Vi, Vim, Neovim
if (( $+commands[nvim] )); then
    alias v='nvim'
elif (( $+commands[vim] )); then
    alias v='vim'
elif (( $+commands[vi] )); then
    alias v='vi'
fi

compile_mod() {
    FrameworkPathOverride=$(dirname $(which mono))/../lib/mono/4.7.2-api/ dotnet build "$1" /property:Configuration=Release
}
