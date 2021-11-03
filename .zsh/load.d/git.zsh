#!/usr/bin/env zsh


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
    alias gau='git add --update'

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
    alias gbd='git branch --delete'
    alias gbdd='git branch --delete --force'
    alias gbr="git branch | grep -v \"master\" | xargs git branch -D"
    alias gbsu='git branch --set-upstream-to'
    alias gbusu='git branch --unset-upstream'

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

if (( $+commands[yadm] )); then
    alias y=yadm
    alias yh='yadm help'
    alias yhi='yadm help init'
    alias yhst='yadm help status'
    alias yhsh='yadm help show'
    alias yhl='yadm help log'
    alias yha='yadm help add'
    alias yhrm='yadm help rm'
    alias yhmv='yadm help mv'
    alias yhr='yadm help reset'
    alias yhcm='yadm help commit'
    alias yhcp='yadm help cherry-pick'
    alias yhrv='yadm help revert'
    alias yht='yadm help tag'
    alias yhn='yadm help notes'
    alias yhsta='yadm help stash'
    alias yhd='yadm help diff'
    alias yhbl='yadm help blame'
    alias yhb='yadm help branch'
    alias yhco='yadm help checkout'
    alias yhlsf='yadm help ls-files'
    alias yhx='yadm help clean'
    alias yhbs='yadm help bisect'
    alias yhm='yadm help merge'
    alias yhrb='yadm help rebase'
    alias yhsm='yadm help submodule'
    alias yhcl='yadm help clone'
    alias yhre='yadm help remote'
    alias yhf='yadm help fetch'
    alias yhu='yadm help pull'
    alias yhp='yadm help push'

    alias yi='yadm init'

    alias yst='yadm status'

    alias ysh='yadm show'
    alias yshs='yadm show --stat'

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
                        alias+="yadm log --decorate"
                        alias+="${graph_flags}${all_flags}"
                        alias+="${oneline_flags}${diff_flags}${search_flags}"
                        alias $alias
                    done
                done
            done
        done
    done

    alias ya='yadm add'
    alias yau='yadm add --update'
    alias yap='yadm add --patch'
    alias yaa='yadm add --all'

    alias yrm='yadm rm'

    alias ymv='yadm mv'

    alias yr='yadm reset'
    alias yrs='yadm reset --soft'
    alias yrh='yadm reset --hard'
    alias yrp='yadm reset --patch'

    alias yc='yadm commit --verbose'
    alias yca='yadm commit --verbose --amend'
    alias ycaa='yadm commit --verbose --amend --all'
    alias ycf='yadm commit -C HEAD --amend'
    alias ycfa='yadm commit -C HEAD --amend --all'
    alias yce='yadm commit --verbose --allow-empty'
    alias ycm='yadm commit -m'
    alias ycma='yadm commit --all -m'
    alias ycam='yadm commit --amend -m'
    alias ycama='yadm commit --amend --all -m'
    alias ycem='yadm commit --allow-empty -m'

    alias ycp='yadm cherry-pick'
    alias ycpc='yadm cherry-pick --continue'
    alias ycpa='yadm cherry-pick --abort'

    alias yrv='yadm revert'
    alias yrva='yadm revert --abort'
    alias yrvm='yadm revert -m'

    alias yt='yadm tag'
    alias ytd='yadm tag --delete'

    alias yn='yadm notes'
    alias yna='yadm notes add'
    alias yne='yadm notes edit'
    alias ynr='yadm notes remove'

    alias ysta='yadm stash save'
    alias ystau='yadm stash save --include-untracked'
    alias ystap='yadm stash save --patch'
    alias ystl='yadm stash list'
    alias ysts='yadm stash show --text'
    alias ystss='yadm stash show --stat'
    alias ystaa='yadm stash apply'
    alias ystp='yadm stash pop'
    alias ystd='yadm stash drop'

    alias yd='yadm diff'
    alias yds='yadm diff --stat'
    alias ydc='yadm diff --cached'
    alias ydcs='yadm diff --cached --stat'
    alias ydn='yadm diff --no-index'

    alias ybl='yadm blame'

    alias yb='yadm branch'
    alias ybd='yadm branch --delete'
    alias ybdd='yadm branch --delete --force'
    alias ybr="yadm branch | grep -v \"master\" | xargs yadm branch -D"
    alias ybsu='yadm branch --set-upstream-to'
    alias ybusu='yadm branch --unset-upstream'

    alias yco='yadm checkout'
    alias ycot='yadm checkout --track'
    alias ycop='yadm checkout --patch'
    alias ycob='yadm checkout -B'

    alias ylsf='yadm ls-files'

    alias yx='yadm clean'
    alias yxu='yadm clean -ffd'
    alias yxi='yadm clean -ffdX'
    alias yxa='yadm clean -ffdx'

    alias ybs='yadm bisect'
    alias ybss='yadm bisect start'
    alias ybsg='yadm bisect good'
    alias ybsb='yadm bisect bad'
    alias ybsr='yadm bisect reset'

    alias ym='yadm merge'
    alias yma='yadm merge --abort'

    alias yrb='yadm rebase'
    alias yrbi='yadm rebase --interactive'
    alias yrbc='yadm rebase --continue'
    alias yrbs='yadm rebase --skip'
    alias yrba='yadm rebase --abort'

    alias ysm='yadm submodule'
    alias ysma='yadm submodule add'
    alias ysms='yadm submodule status'
    alias ysmi='yadm submodule init'
    alias ysmd='yadm submodule deinit'
    alias ysmu='yadm submodule update'
    alias ysmui='yadm submodule update --init --recursive'
    alias ysmf='yadm submodule foreach'
    alias ysmy='yadm submodule sync'

    alias ycl='yadm clone --recursive'
    alias ycls='yadm clone --depth=1 --single-branch --no-tags'

    alias yre='yadm remote'
    alias yrel='yadm remote list'
    alias yres='yadm remote show'

    alias yf='yadm fetch --prune'
    alias yfa='yadm fetch --all --prune'
    alias yfu='yadm fetch --unshallow'

    alias yu='yadm pull'
    alias yur='yadm pull --rebase --autostash'
    alias yum='yadm pull --no-rebase'

    alias yp='yadm push'
    alias ypa='yadm push --all'
    alias ypf='yadm push --force-with-lease'
    alias ypff='yadm push --force'
    alias ypu='yadm push --set-upstream'
    alias ypd='yadm push --delete'
    alias ypt='yadm push --tags'
fi
