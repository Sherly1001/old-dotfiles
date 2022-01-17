alias cls=clear
alias py=python3
alias ipy=ipython3
alias jn=jupyter-notebook
alias jl=jupyter-lab
alias t='tree -L 4'
alias tl='tree -L'

alias sls='screen -ls'
alias sr='screen -r'
alias sn='screen -S'

alias cm='cmake -B build -S .'
alias cmb='cmake --build build'

alias fm='astyle -A2s4SpHUk3W3xfxhOn'
clfm() {
    style="`sed -re '/(\s*#.*$|^\s*$)/d' -e 's/$/,/' ~/.clang-format`"
    clang-format --style="{ $style }" "$@"
}

alias gco='git checkout'
alias gcoo='gco master'
alias gcm='git commit -m'
alias gad='git add'
alias glg='git log'
alias glo='git log --oneline'
alias gla='git log --oneline --graph --all'
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
ghp() { git subtree -P "$1" push origin gh-pages ;}
gi() { curl -sL "https://www.toptal.com/developers/gitignore/api/$@" ;}

shopt -s autocd
exec {BASH_XTRACEFD}>/dev/null

export VISUAL=vim
export EDITOR=vim

__git_ps () {
    [[ `git branch 2>&1 1>/dev/null` ]] && return 0
    # get branch for git old version
    # br=`git branch 2>/dev/null`
    # [[ -z $br && $? -eq 0 ]] && br='* master'
    # br=`echo "$br" | sed -n 's/^* //p'`
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

    [[ -z $br ]] && br="no branch"
    echo -e "$bk[$cl$br$bk]\033[m"
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

wf() {
    local OPTIND
    local OPTARG
    local opt

    while getopts ":adhisc:" opt; do
        case "${opt}" in
            a)
                ip a
                return;;
            c)
                nmcli connect up "$OPTARG" 2>/dev/null && return
                nmcli -a device wifi connect "$OPTARG"
                return;;
            s)
                nmcli connect
                return;;
            d)
                nmcli device
                return;;
            i)
                echo ip: `curl -s ifconfig.me`
                return;;
            h)
                echo 'usage: wf [option]'
                echo '   option:'
                echo '      -c <ssid>   : connect to <ssid>'
                echo '      -d          : show devices'
                echo '      -s          : show saved connects'
                echo '      -a          : like `ip a` command'
                echo '      -i          : show public ip'
                echo '      -h          : show this table'
                echo '      no option   : show wifi list'
                return;;
        esac
    done
    nmcli device wifi list
}
