#!/usr/local/bin/env zsh
# Name: zshrc
# Author: Michael Ciociola
# License: GPLv3


# Zsh
_comp_options+=(globdots)
alias d='dirs -v'
alias sz="source $HOME/.zshrc"
autoload -U compinit; compinit
export KEYTIMEOUT=1
export ZDOTDIR="$HOME"
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
unsetopt CASE_GLOB
setopt GLOB_COMPLETE

export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=922337203685477580
export SAVEHIST="$HISTSIZE"

[ -f "$HOME/.zpers" ] &&  . "$HOME/.zpers"

# bindkey -v

for index ({1..9}) alias "$index"="cd +${index}"; unset index

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
export PATH="$HOME/.local/bin:$HOME/.bin:$PATH"
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Nvim
export VIMINIT="source $HOME/.config/nvim/init.vim"

# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export _JAVA_AWT_WM_NONREPARENTING=1

# Application Data
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# UI
export XCURSOR_SIZE="32"
export QT_QPA_PLATFORMTHEME=gtk3

# FD
if (( $+commands[fdfind] )); then
    alias fd='fdfind'
fi

# FZF
[ -f "$HOME/.config/fzf/.fzf.zsh"    ]  && . "$HOME/.config/fzf/.fzf.zsh"
export FZF_ALT_C_COMMAND='fd --type=d -H -E .git -E .cache'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS='--sort --exact'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_COMMAND='fd --type=f -H -E .git -E .cache'
export FZF_DEFAULT_OPTS='--no-height --no-reverse'
export FZF_TMUX=0


# ls after cd
cd() {
    builtin cd "$@" && ls -F --color=tty
}

# Usage: delink <path>
#
# Resolve the symlink at the given path and replace it with a copy of
# the file it points to.
function delink {
    emulate -LR zsh
    if [[ -z $1 ]]; then
        echo >&2 "usage: delink <symlinks>"
        return 1
    fi
    for link; do
        if [[ -L $link ]]; then
            if [[ -e $link ]]; then
                target=${link:A}
                if rm $link; then
                    if cp -R $target $link; then
                        echo >&2 "Copied $target to $link"
                    else
                        ln -s $target $link
                    fi
                fi
            else
                echo >&2 "Broken symlink: $link"
            fi
        else
            echo >&2 "Not a symlink: $link"
        fi
    done
}


# Emacs
if (( $+commands[emacs] )); then
    alias e='emacs -nw'
    alias eg='emacs'
    alias ec='emacs --with-profile doom -nw'
    alias ecg='emacs --with-profile doom'
    alias ue='USER_EMACS_DIRECTORY=$PWD e'
    alias uew='USER_EMACS_DIRECTORY=$PWD ew'

    if [[ "$TERM" == "xterm-kitty" ]] || [[ "$TERM" == "tmux-256color" ]]; then
        alias emacs="TERM=kitty-direct emacs"
    fi
    if [[ -d "$HOME/.emacs.doom/bin" ]]; then
        PATH="$PATH:$HOME/.emacs.doom/bin"
    fi
fi


if (( $+commands[emacsclient] )); then
    alias ec='emacsclient --alternate-editor= -nw'
    alias ecw='emacsclient --alternate-editor='
fi

if (( $+commands[docker] )); then
    alias dr='docker run -it --rm'
fi

# Directory aliases
alias rd='rmdir'
alias md='mkdir -p'
alias di='dirs -v | head -10'

function mcd {
    emulate -LR zsh
    mkdir -p $@
    cd ${@[$#]}
}

# Ls
alias ls="ls --color"
alias l="ls -AlhF"
alias lr="l -tr"

if (( $+commands[tree] )); then
    alias lt='tree -a'
    alias ltl='tree -aL'
fi

# Journalctl
alias jc="sudo journalctl"
alias jcu="journalctl --user"

# Systemctl
alias sc="sudo systemctl"
alias scd="sudo systemctl disable"
alias scdn="sudo systemctl disable --now"
alias scdr="sudo systemctl daemon-reload"
alias sce="sudo systemctl enable"
alias scen="sudo systemctl enable --now"
alias scr="sudo systemctl restart"
alias scs="sudo systemctl status"
alias scsa="sudo systemctl start"
alias scso="sudo systemctl stop"
alias scu="systemctl --user"
alias scud="systemctl --user disable"
alias scudn="systemctl --user disable --now"
alias scudr="systemctl --user daemon-reload"
alias scue="systemctl --user enable"
alias scuen="systemctl --user enable --now"
alias scur="systemctl --user restart"
alias scus="systemctl --user status"
alias scusa="systemctl --user start"
alias scuso="systemctl --user stop"

# Misc
alias redshift="redshift -l 35:-80 -t 5700:3600 -m randr"
alias smi="sudo make install"
alias tb="nc termbin.com 9999"
alias tm="tmux"
alias ytb="youtube-dl -f best"

# Git
alias g="git"
alias gbr="git branch | grep -v \"master\" | xargs git branch -D" # removes all other git branches
alias gd="git diff"
alias gl="git log"
alias gs="git status"

alias y="yadm"
alias ys="yadm status"
alias yl="yadm log"

# ZFS
alias zpe='sudo zpool export zroot'
alias zpi='sudo zpool import -f zroot'
alias zla='zfs list -t all'
alias zl='zfs list -o name,available,used,usedbychildren,usedbysnapshots,usedbydataset -H | grep -v docker | column -t -N name,available,used,children,snapshots,dataset'
alias zp='zpool status'
alias zk='sudo zfs load-key -a'
alias zm='sudo zfs mount -a'
alias zks='sudo zfs get -p keystatus'

# Mounting
alias sshfs="sshfs -o compression=no,reconnect,cache=yes,kernel_cache"
alias mtm="mkdir -p ~/library; sshfs iroh:library ~/library; mkdir -p ~/torrents ; sshfs iroh:/media/torrents torrents"


#### Vi, Vim, Neovim

if (( $+commands[nvim] )); then
    alias v='nvim'
elif (( $+commands[vim] )); then
    alias v='vim'
elif (( $+commands[vi] )); then
    alias v='vi'
fi

#### Tmux

if (( $+commands[tmux] )); then
    alias ta='tmux attach'
    function ts {
        tmux new-session -s ${1:-tmux}
    }
    alias tl='tmux list-sessions'
fi

# mpv
if [[ $HOST == "hatsune" ]]; then
  # alias mpv="mpv --vo=gpu --hwdec=auto"
  alias mpv="mpv --vo=gpu --gpu-context=x11vk --gpu-api=vulkan --vulkan-queue-count=8 --hwdec=vaapi-copy"
fi


if (( $+commands[hub] )); then
    alias hcl='hub clone --recursive'
    alias hc='hub create --copy'
    alias hcp='hub create -p --copy'
    alias hf='hub fork'
    alias hp='hub pull-request --copy'
    alias hb='hub browse'
    alias hh='hub help'
    alias hi='hub issue'
fi


if (( $+commands[git] )); then
    alias g=git

    alias gh='git help'
    alias ghi='git help init'
    alias ghst='git help status'
    alias ghsh='git help show'
    alias ghl='git help log'
    alias gha='git help add'
    alias ghrm='git help rm'
    alias ghmv='git help mv'
    alias ghr='git help reset'
    alias ghcm='git help commit'
    alias ghcp='git help cherry-pick'
    alias ghrv='git help revert'
    alias ght='git help tag'
    alias ghn='git help notes'
    alias ghsta='git help stash'
    alias ghd='git help diff'
    alias ghbl='git help blame'
    alias ghb='git help branch'
    alias ghco='git help checkout'
    alias ghlsf='git help ls-files'
    alias ghx='git help clean'
    alias ghbs='git help bisect'
    alias ghm='git help merge'
    alias ghrb='git help rebase'
    alias ghsm='git help submodule'
    alias ghcl='git help clone'
    alias ghre='git help remote'
    alias ghf='git help fetch'
    alias ghu='git help pull'
    alias ghp='git help push'

    alias gi='git init'

    alias gst='git status'

    alias gsh='git show'
    alias gshs='git show --stat'

    for nograph in "" n; do
        local graph_flags=
        if [[ -z $nograph ]]; then
            graph_flags=" --graph"
        fi
        for all in "" a; do
            local all_flags=
            if [[ -n $all ]]; then
                all_flags=" --all"
            fi
            for oneline in "" o; do
                local oneline_flags=
                if [[ -n $oneline ]]; then
                    oneline_flags=" --oneline"
                fi
                for diff in "" s p ps sp; do
                    local diff_flags=
                    case $diff in
                        s) diff_flags=" --stat";;
                        p) diff_flags=" --patch";;
                        ps|sp) diff_flags=" --patch --stat";;
                    esac
                    for search in "" g G S; do
                        local search_flags=
                        case $search in
                            g) search_flags=" --grep";;
                            G) search_flags=" -G";;
                            S) search_flags=" -S";;
                        esac
                        alias="gl${nograph}${all}${oneline}${diff}${search}="
                        alias+="git log --decorate"
                        alias+="${graph_flags}${all_flags}"
                        alias+="${oneline_flags}${diff_flags}${search_flags}"
                        alias $alias
                    done
                done
            done
        done
    done

    alias ga='git add'
    alias gap='git add --patch'
    alias gaa='git add --all'

    alias grm='git rm'

    alias gmv='git mv'

    alias gr='git reset'
    alias grs='git reset --soft'
    alias grh='git reset --hard'
    alias grp='git reset --patch'

    alias gc='git commit --verbose'
    alias gca='git commit --verbose --amend'
    alias gcaa='git commit --verbose --amend --all'
    alias gcf='git commit -C HEAD --amend'
    alias gcfa='git commit -C HEAD --amend --all'
    alias gce='git commit --verbose --allow-empty'
    alias gcm='git commit -m'
    alias gcma='git commit --all -m'
    alias gcam='git commit --amend -m'
    alias gcama='git commit --amend --all -m'
    alias gcem='git commit --allow-empty -m'

    alias gcp='git cherry-pick'
    alias gcpc='git cherry-pick --continue'
    alias gcpa='git cherry-pick --abort'

    alias grv='git revert'
    alias grva='git revert --abort'
    alias grvm='git revert -m'

    alias gt='git tag'
    alias gtd='git tag --delete'

    alias gn='git notes'
    alias gna='git notes add'
    alias gne='git notes edit'
    alias gnr='git notes remove'

    alias gsta='git stash save'
    alias gstau='git stash save --include-untracked'
    alias gstap='git stash save --patch'
    alias gstl='git stash list'
    alias gsts='git stash show --text'
    alias gstss='git stash show --stat'
    alias gstaa='git stash apply'
    alias gstp='git stash pop'
    alias gstd='git stash drop'

    alias gd='git diff'
    alias gds='git diff --stat'
    alias gdc='git diff --cached'
    alias gdcs='git diff --cached --stat'
    alias gdn='git diff --no-index'

    alias gbl='git blame'

    alias gb='git branch'
    alias gbsu='git branch --set-upstream-to'
    alias gbusu='git branch --unset-upstream'
    alias gbd='git branch --delete'
    alias gbdd='git branch --delete --force'

    alias gco='git checkout'
    alias gcot='git checkout --track'
    alias gcop='git checkout --patch'
    alias gcob='git checkout -B'

    alias glsf='git ls-files'

    alias gx='git clean'
    alias gxu='git clean -ffd'
    alias gxi='git clean -ffdX'
    alias gxa='git clean -ffdx'

    alias gbs='git bisect'
    alias gbss='git bisect start'
    alias gbsg='git bisect good'
    alias gbsb='git bisect bad'
    alias gbsr='git bisect reset'

    alias gm='git merge'
    alias gma='git merge --abort'

    alias grb='git rebase'
    alias grbi='git rebase --interactive'
    alias grbc='git rebase --continue'
    alias grbs='git rebase --skip'
    alias grba='git rebase --abort'

    alias gsm='git submodule'
    alias gsma='git submodule add'
    alias gsms='git submodule status'
    alias gsmi='git submodule init'
    alias gsmd='git submodule deinit'
    alias gsmu='git submodule update'
    alias gsmui='git submodule update --init --recursive'
    alias gsmf='git submodule foreach'
    alias gsmy='git submodule sync'

    alias gcl='git clone --recursive'
    alias gcls='git clone --depth=1 --single-branch --no-tags'

    alias gre='git remote'
    alias grel='git remote list'
    alias gres='git remote show'

    alias gf='git fetch --prune'
    alias gfa='git fetch --all --prune'
    alias gfu='git fetch --unshallow'

    alias gu='git pull'
    alias gur='git pull --rebase --autostash'
    alias gum='git pull --no-rebase'

    alias gp='git push'
    alias gpa='git push --all'
    alias gpf='git push --force-with-lease'
    alias gpff='git push --force'
    alias gpu='git push --set-upstream'
    alias gpd='git push --delete'
    alias gpt='git push --tags'
fi

# Arch Linux
function paclist() {
  # Based on https://bbs.archlinux.org/viewtopic.php?id=93683
  pacman -Qqe | \
    xargs -I '{}' \
      expac "${bold_color}% 20n ${fg_no_bold[white]}%d${reset_color}" '{}'
}

function pacdisowned() {
  local tmp db fs
  tmp=${TMPDIR-/tmp}/pacman-disowned-$UID-$$
  db=$tmp/db
  fs=$tmp/fs

  mkdir "$tmp"
  trap 'rm -rf "$tmp"' EXIT

  pacman -Qlq | sort -u > "$db"

  sudo find /bin /etc /lib /sbin /usr ! -name lost+found \
    \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}

alias pacmanallkeys='sudo pacman-key --refresh-keys'

function pacmansignkeys() {
  local key
  for key in $@; do
    sudo pacman-key --recv-keys $key
    sudo pacman-key --lsign-key $key
    printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg \
      --no-permission-warning --command-fd 0 --edit-key $key
  done
}

if (( $+commands[xdg-open] )); then
  function pacweb() {
    if [[ $# = 0 || "$1" =~ '--help|-h' ]]; then
      local underline_color="\e[${color[underline]}m"
      echo "$0 - open the website of an ArchLinux package"
      echo
      echo "Usage:"
      echo "    $bold_color$0$reset_color ${underline_color}target${reset_color}"
      return 1
    fi

    local pkg="$1"
    local infos="$(LANG=C pacman -Si "$pkg")"
    if [[ -z "$infos" ]]; then
      return
    fi
    local repo="$(grep -m 1 '^Repo' <<< "$infos" | grep -oP '[^ ]+$')"
    local arch="$(grep -m 1 '^Arch' <<< "$infos" | grep -oP '[^ ]+$')"
    xdg-open "https://www.archlinux.org/packages/$repo/$arch/$pkg/" &>/dev/null
  }
fi


src() {
	local cache="$ZSH_CACHE_DIR"
	autoload -U compinit zrecompile
	compinit -i -d "$cache/zcomp-$HOST"

	for f in ${ZDOTDIR:-~}/.zshrc "$cache/zcomp-$HOST"; do
		zrecompile -p $f && command rm -f $f.zwc.old
	done

	# Use $SHELL if it's available and a zsh shell
	local shell="$ZSH_ARGZERO"
	if [[ "${${SHELL:t}#-}" = zsh ]]; then
		shell="$SHELL"
	fi

	# Remove leading dash if login shell and run accordingly
	if [[ "${shell:0:1}" = "-" ]]; then
		exec -l "${shell#-}"
	else
		exec "$shell"
	fi
}



# Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme

if [ `tput colors` != "256" ]; then
    [[ ! -f ~/.p10k8.zsh ]] || source ~/.p10k8.zsh
else
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
