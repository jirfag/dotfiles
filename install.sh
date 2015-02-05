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
fi

vim +PluginInstall +qall

if [ ! -f ~/.vim/colors/solarized.vim ]; then
    mkdir -p ~/.vim/colors
    ln ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/solarized.vim
fi

if [ ! "$(ls -A ~/.vim/bundle/YouCompleteMe)" ]; then
    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer
fi

sudo npm install -g jslint # for syntastic for vim
mkdir -p ~/bin
rm -f ~/bin/get_tmux_status.sh
ln get_tmux_status.sh ~/bin/get_tmux_status.sh
