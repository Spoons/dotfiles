#!/usr/bin/env zsh

if [ `tput colors` != "256" ]; then
    [[ ! -f $ZDIR/p10k/p10k8.zsh ]] || source $ZDIR/p10k/p10k8.zsh
else
    [[ ! -f $ZDIR/p10k/p10k.zsh ]] || source $ZDIR/p10k/p10k.zsh
fi


# Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme
