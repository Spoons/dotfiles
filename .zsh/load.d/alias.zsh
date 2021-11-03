#!/usr/bin/env zsh
# File for unsorted aliases and functions

if (( $+commands[fdfind] )); then
    alias fd='fdfind'
fi
if (( $+commands[tidal-dl] )); then
    alias tdl="tidal-dl -l"
fi
if (( $+commands[docker] )); then
    alias dr='docker run -it --rm'
fi

# Misc
alias redshift="redshift -l 35:-80 -t 5700:3600 -m randr"
alias smi="sudo make install"
alias ytb="youtube-dl -f best"

#### Tmux
if (( $+commands[tmux] )); then
    alias ta='tmux attach'
    function ts {
        tmux new-session -s ${1:-tmux}
    }
    alias tl='tmux list-sessions'
fi

# mpv
case $HOST in
    "hatsune")
        alias mpv="mpv --vo=gpu --gpu-context=x11vk --gpu-api=vulkan --vulkan-queue-count=8 --hwdec=vaapi-copy";;
    "iroh")
        alias mpv="mpv --vo=gpu --profile=gpu-hq --cscale=ewa_lanczossharp --scale=ewa_lanczossharp --video-sync=display-resample --interpolation --tscale=catmull_rom";;
esac

edit_common_config_file() {
    eval $EDITOR "$(find $HOME/.zsh/load.d -type f | fzf)"
}

alias ecz="$EDITOR $HOME/.zshrc"
alias ecp="edit_common_config_file"
alias ecb="$EDITOR $XDG_CONFIG_HOME/bspwm/bspwmrc"
alias ecs="$EDITOR $XDG_CONFIG_HOME/sxhkd/sxhkdrc"
alias ecpb="$EDITOR $XDG_CONFIG_HOME/polybar/config"
alias ecx="$EDITOR $HOME/.xinitrc"
alias reload="exec zsh -l"

alias lxo="less $HOME/.cache/Xoutput"

alias Y="| yank "
alias YL="| yank -l"
alias E="| emacs -nw -"
alias E="| vim -"
alias FZF="| fzf "
alias G="| grep -i "
alias GV="| grep -iV "
alias L="| less"
alias R="| rg"
alias TB="| nc termbin.com 9999"
alias X="| xargs "

alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm}=mpv
alias -s {py,c,cpp,sh,zsh,bash}="emacs -nw"
alias -s {jpg,jpeg,webp,png,tiff,raw,bmp,gif,svg}="fzf -."
alias -s pdf="evince"
alias -s {doc,docx,odf,odg,ods,dt,ott,pub}=libreoffice
alias -s git="git clone"

globalias() {
    if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}
zle -N globalias
bindkey " " globalias # space key to expand globalalias
