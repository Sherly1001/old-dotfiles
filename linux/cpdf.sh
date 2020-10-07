
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
fi

if [[ $(echo $@ | grep -e '\-v' -e '-a') ]]; then
    if [[ -e ~/.vim ]]; then
        rm ~/.vim
        echo "rm ~/.vim"
    fi
    if [[ -e ~/.vimrc ]]; then
        rm ~/.vimrc
        echo "rm ~/.vimrc"
    fi
    echo "ln -s $(pwd)/.vim ~/.vim"
    ln -s `pwd`/.vim ~/.vim
    echo "ln -s $(pwd)/.vimrc ~/.vimrc"
    ln -s `pwd`/.vimrc ~/.vimrc
fi

if [[ $(echo $@ | grep -e '\-z' -e '-a') ]]; then
    cp .zshrc ~/
    echo "cp .zshrc ~/"
fi

