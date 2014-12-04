function inst() {
    test -f ~/$1 && rm -f ~/$1.bak && mv ~/$1 ~/$1.bak
    ln $1 ~/$1
    echo "ln $1 ~/$1"
}

inst .bashrc
inst .gitconfig
inst .tmux.conf
inst .vimrc
inst .git-prompt.sh

VUNLDE_INST_DIR=~/.vim/bundle/Vundle.vim
if [ ! -d "$VUNLDE_INST_DIR" ]; then
    echo "install Vundle"
    git clone https://github.com/gmarik/Vundle.vim.git $VUNLDE_INST_DIR
    vim +PluginInstall +qall
fi
