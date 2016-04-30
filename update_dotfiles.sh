function inst() {
    echo "ln $1 ~/$1"
    test -f ~/$1 && rm -f ~/$1.bak && mv ~/$1 ~/$1.bak
    ln $1 ~/$1 || { echo "can't do ln"; exit 1; }
}

inst .bashrc
inst .gitconfig
inst .tmux.conf
inst .vimrc
inst .git-prompt.sh
