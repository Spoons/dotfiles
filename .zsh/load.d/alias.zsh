#!/usr/bin/env zsh
# File for unsorted aliases and functions

zstyle ':completion:*' completer _expand_alias _complete _ignored

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
alias ytb="youtube-dl-fast -f best"

#### Tmux
if (( $+commands[tmux] )); then
    alias ta='tmux attach'
    ts () {
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
    # eval $EDITOR "$(fd -t f ~/.zsh/load.d ~/.bin ~/.zshrc ~/.config | fzf --delimeter / --with-nth -1)"
    eval $EDITOR "$(search_common_files | fzf)"
}

edit_zsh_config_file() {
    # eval $EDITOR "$(fd -t f ~/.zsh/load.d ~/.bin ~/.zshrc ~/.config | fzf --delimeter / --with-nth -1)"
    eval $EDITOR "$(( cd ~ ; echo .zshrc && fd -t f . .zsh/load.d .bin  ) | fzf)"
}

open_with_emacs() {
    emacsclient -nw $@
}

alias ecc=edit_common_config_file
alias ecz="$EDITOR $HOME/.zshrc"
# alias ecp="edit_common_config_file"
alias ecb="$EDITOR $XDG_CONFIG_HOME/bspwm/bspwmrc"
alias ecs="$EDITOR $XDG_CONFIG_HOME/sxhkd/sxhkdrc"
alias ecpb="$EDITOR $XDG_CONFIG_HOME/polybar/config"
alias ecx="$EDITOR $HOME/.xinitrc"
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

hash -d rmm=~/dev/rmm
hash -d rw=~/apps/rimworld
hash -d mods=~/apps/rimworld/game/Mods
hash -d doc=~/personal/document
hash -d media=~/media
hash -d torrent=~/media/torrents
hash -d download=~/local/download
hash -d desktop=~/local/desktop
hash -d wallpaper=~/library/images/wallpapers
hash -d screenshots=~/personal/image/screenshots
hash -d pkg=/mnt/build/makepkg/pkgdest
hash -d src=/mnt/build/makepkg/srcdest
