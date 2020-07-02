alias cls=clear
alias py=python3
alias ..='cd ..'
alias t='tree -L 4'
alias tl='tree -L'

alias fm='astyle -A2s4SpHUk3W3xfxhOn'

alias gco='git checkout'
alias gcoo='gco master'
alias gcm='git commit -m'
alias gad='git add'
alias glg='git log'
alias gpu='git push'
alias gcl='git clone'
alias gmg='git merge'
alias gbr='git branch'
alias gst='git status'

shopt -s autocd
exec {BASH_XTRACEFD}>/dev/null

export VISUAL=vim
export EDITOR=vim

source ~/.git-prompt.sh

git_color () {
    if [[ $(git status 2> /dev/null | grep -e "Changes not staged for commit" -e "Untracked files" -e "Unmerged paths") ]]; then
        echo -e "\033[0;31m";
    elif [[ $(git status 2> /dev/null | grep -e "Changes to be committed" -e "All conflicts fixed but you are still merging") ]]; then
        echo -e "\033[1;33m";
    else
        echo -e "\033[1;32m";
    fi
}

__sher_ps="\[\e]0;\u@\h: \w\a\]\${debian_chroot:+(\$debian_chroot)}\[\e[01;32m\]\u@\h: \[\e[01;34m\]\w\[\$(git_color)\]\$(__git_ps1)\n"

export PS1="\$(if [ \$? == 0 ];then arw=\"\[\e[01;32m\]-> \";else arw=\"\[\e[01;31m\]-> \";fi;echo \"$__sher_ps\$arw\[\e[0m\]\")"

export PS2='>> '


b() {
    if [[ -z $1 ]]; then
        echo "no input file"
        return
    fi
    cmd=""
    if [[ $1 =~ \.cpp$ ]]; then
        cmd+="g++ "
    else
        cmd+="gcc "
    fi
    cmd+="'$1' "
    
    if [[ -z $2 ]] || [[ $2 = "." ]]; then
        cmd+="-o '$(echo $1 | sed -e "s/\.cp*$//i")'"
    else
        cmd+="-o '$2'"
    fi

    for (( i = 3; i <= $#; ++i )); do
        cmd+=" '${!i}'"
    done

    echo $cmd
    eval "$cmd"
}

