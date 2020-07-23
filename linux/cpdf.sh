
if [[ -z $1 ]]; then
    echo "usage: ./cpdf.sh [opt]"
    echo "[opt]: -a: copy all files"
    echo "       -b: copy bash files"
    echo "       -v: copy vim files"
    echo "       -z: copy zsh files"
    exit 1
fi

if [[ $(echo $@ | grep -e '\-b' -e '-a') ]]; then
    cp .inputrc ~/
    echo "cp .inputrc ~/"
    cp .bashrc ~/
    echo "cp .bashrc ~/"
    cp .sher.sh ~/
    echo "cp .sher.sh ~/"
    cp .git-prompt.sh ~/
    echo "cp .git-prompt.sh ~/"
fi

if [[ $(echo $@ | grep -e '\-v' -e '-a') ]]; then
    cp -fr .vim ~/
    echo "cp -fr .vim ~/"
    cp .vimrc ~/
    echo "cp .vimrc ~/"
fi

if [[ $(echo $@ | grep -e '\-z' -e '-a') ]]; then
    cp .zshrc ~/
    echo "cp .zshrc ~/"
fi

