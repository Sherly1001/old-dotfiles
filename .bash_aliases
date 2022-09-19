alias cls=clear

alias sudo='sudo '
alias bat='cat /sys/class/power_supply/BAT0/capacity'
alias bat-stt='cat /sys/class/power_supply/BAT0/status'

alias vi=nvim
alias nv='neovide --multigrid'

alias dp=docker-compose

alias py=python3
alias ipy=ipython3
alias jn=jupyter-notebook
alias jl=jupyter-lab

alias t='tree -L 4'
alias tl='tree -L'
alias nr='npm run'
alias ni='npm install'

alias sls='screen -ls'
alias sr='screen -r'
alias sn='screen -S'

alias cm='cmake -B build -S .'
alias cmb='cmake --build build'

alias fm='astyle -A2s4SpHUk3W3xfxhOn'
clfm() {
    style=`sed -re '/(\s*#.*$|^\s*$)/d' -e 's/$/,/' ~/.clang-format`
    clang-format --style="{ $style }" "$@"
}

alias gco='git checkout'
alias gcoo='gco master'
alias gcm='git commit -m'
alias gcma='git commit --amend'
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

co() {(
    cd $1
    shift 1
    eval "$@"
)}

yl() {
    yay -Qi | awk '/^Name/ { name = $3 } match($0, /^Required By.*: (.*)/, a) { req = a[1] } /^Installed Size/ { print $4$5, name, ":", req }' | sort -hr $@
}
