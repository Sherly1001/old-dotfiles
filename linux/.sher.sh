alias cls=clear
alias py=python3
alias ..='cd ..'
alias t='tree -L 4'
alias tl='tree -L'

alias fm='astyle -A2s4SpHUk3W3xfxhOn'
alias clfm="clang-format --style='{ AllowShortFunctionsOnASingleLine: Empty, AllowShortIfStatementsOnASingleLine: WithoutElse, AllowShortLoopsOnASingleLine: true, IncludeBlocks: Regroup, IndentCaseLabels: true, IndentWidth: 4, SortIncludes: false }' -i"

alias gco='git checkout'
alias gcoo='gco master'
alias gcm='git commit -m'
alias gad='git add'
alias glg='git log'
alias glo='git log --oneline'
alias gpu='git push'
alias gpl='git pull'
alias gft='git fetch'
alias gcl='git clone'
alias gmg='git merge'
alias gbr='git branch'
alias gst='git status'
alias gdf='git diff'
alias gdc='git diff --cached'
alias gd='git diff --no-index'
gi() { curl -sL "https://www.toptal.com/developers/gitignore/api/$@" ;}

shopt -s autocd
exec {BASH_XTRACEFD}>/dev/null

export VISUAL=vim
export EDITOR=vim

__git_ps () {
    br=`git branch --show-current 2>/dev/null`
    st=`git status -s 2>/dev/null | awk '/^\w/ { i = "i"; } /^.\w/ { w = "w"; } /^\?\?/ { u = "u"; } END { print u w i }'`

    if [[ $st = *u* || $st = *w* ]]; then
        cl="\033[1;31m"
        bk="\033[1;31m"
    elif [[ $st = *i* ]]; then
        cl="\033[1;33m"
    else
        cl="\033[1;32m"
        bk="\033[1;32m"
    fi

    if [[ $st = *i* ]]; then
        bk="\033[1;33m"
    fi

    [[ $br ]] && echo -e "$bk[$cl$br$bk]\033[m"
}

__sher_ps="\[\e]0;\u@\h: \w\a\]\${debian_chroot:+(\$debian_chroot)}\[\e[01;32m\]\u@\h: \[\e[01;34m\]\w \[\$(__git_ps)\]\n"

export PS1="\$(if [ \$? == 0 ];then arw=\"\[\e[01;32m\]-> \";else arw=\"\[\e[01;31m\]-> \";fi;echo \"$__sher_ps\$arw\[\e[0m\]\")"

export PS2='>> '


b() {
    local CC=gcc # clang or gcc

    if [[ -z $1 ]]; then
        echo -e "\e[1;31mno input files\e[0m"
        return 1
    fi

    local args=("$@")
    local inp="${args[0]}"
    local ext="${inp##*.}"
    local out="${inp%.*}"
    local g='' other='' i=''

    shopt -s nocasematch
    if [[ $ext == cpp ]]; then
        if [[ $CC == gcc ]]; then CC=g++
        else CC=clang++
        fi
    fi
    shopt -u nocasematch

    if [[ -n ${args[1]} && ${args[1]} != '.' && ${args[1]} != '-g' ]]; then
        out="${args[1]}"
    fi

    for ((i = 1; i < $#; ++i)); do
        if [[ ${args[$i]} == '-g' ]]; then
            g=' -g'
            unset args[i]
            break
        fi
    done

    other=$(printf " '%s'" "${args[@]:2:$#}")
    if [[ $other == " ''" ]]; then
        other=''
    fi

    local cmd="$CC$g '$inp' -o '$out'$other"
    echo "$cmd"
    eval "$cmd"
}
