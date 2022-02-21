#!/usr/bin/env zsh
# File for unsorted aliases and functions

zstyle ':completion:*' completer _expand_alias _complete _ignored

if (( $+commands[fdfind] )); then
    alias fd="fdfind"
fi
if (( $+commands[tidal-dl] )); then
    alias tdl="tidal-dl -l"
fi
if (( $+commands[docker] )); then
    alias dr="docker run -it --rm"
fi

#### Tmux
if (( $+commands[tmux] )); then
    alias ta="tmux attach"
    ts () {
        tmux new-session -s ${1:-tmux}
    }
    alias tl="tmux list-sessions"
fi

# mpv
case $HOST in
    "iroh")
        alias mpv="mpv --vo=gpu --profile=gpu-hq --cscale=ewa_lanczossharp --scale=ewa_lanczossharp --video-sync=display-resample --interpolation --tscale=catmull_rom";;
esac

search_common_files() {
    (
        cd ~
        fd -H -t f -d 1 "^\..*" . &&
        fd -d 1 -t f . .zsh/load.d .bin .config .emacs.d .pbin .vnc .xmonad &&
        echo ".ssh/config"
        echo ".local/share/gnupg/gpg.conf"
        echo ".local/share/gnupg/dirmngr.conf"
    )

}

edit_common_config_file() {
    local select="$(search_common_files | fzf)"
    [[ -n "$select" ]] && eval $EDITOR "$select"
}


open_with_emacs() {
    emacsclient -nw $@
}

cd() { builtin cd "$@"; ls }

alias ecc="edit_common_config_file"
alias ecz="eval $EDITOR $HOME/.zshrc"
alias ecb="eval $EDITOR $XDG_CONFIG_HOME/bspwm/bspwmrc"
alias ecs="eval $EDITOR $XDG_CONFIG_HOME/sxhkd/sxhkdrc"
alias ecpb="eval $EDITOR $XDG_CONFIG_HOME/polybar/config"
alias ecx="eval $EDITOR $HOME/.xinitrc"
alias rl="exec zsh -l"
alias lxo="less $HOME/.cache/Xoutput"
alias Y="| yank "
alias YL="| yank -l"
alias E="| emacs -nw -"
alias FZF="| fzf "
alias G="| grep -i "
alias GV="| grep -iV "
alias L="| less"
alias R="| rg"
alias TB="| nc termbin.com 9999"
alias X="| xargs "

alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm}=mpv
# alias -s {jpg,jpeg,webp,png,tiff,raw,bmp,gif,svg}="fzf -."
alias -s {jpg,jpeg,webp,png,tiff,raw,bmp,gif,svg}="wget" 
alias -s pdf="evince"
alias -s {doc,docx,odf,odg,ods,dt,ott,pub}=libreoffice
alias -s git="git clone"

globalias() {
    if [[ $LBUFFER =~ "[A-Z0-9]+$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}
zle -N globalias
bindkey " " globalias # space key to expand globalalias

hash -d rmm=~/dev/rmm
hash -d rimworld=~/games/rimworld
hash -d doc=~/personal/document
hash -d media=/mnt/media
hash -d music=/mnt/media/music
hash -d torrent=/mnt/media/torrents
hash -d download=~/local/download
hash -d desktop=~/local/desktop
hash -d wallpapers=~/library/images/wallpapers
hash -d screenshots=~/personal/image/screenshots
hash -d pkg=/mnt/build/makepkg/pkgdest
hash -d src=/mnt/build/makepkg/srcdest
