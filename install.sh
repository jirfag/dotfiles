STATUS_FILE="./status.txt"

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

if echo "$(uname -a)" | grep -qi ubuntu; then
    echo "install ubuntu packages"
    CMD="sudo apt-get install -y exuberant-ctags npm build-essential cmake python-dev"
    eval $CMD || { sudo apt-get update; eval $CMD; }
fi

vim +PluginInstall +qall

if [ ! -f ~/.vim/colors/solarized.vim ]; then
    mkdir -p ~/.vim/colors
    ln ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/solarized.vim
fi

if [ -f ~/.vim/bundle/YouCompleteMe/install.sh ]; then
    if ! grep -q ycm $STATUS_FILE; then
        echo "install YCM core"
        cd ~/.vim/bundle/YouCompleteMe
        ./install.sh --clang-completer
        echo ycm >>$STATUS_FILE
    fi
fi

sudo npm install -g jslint # for syntastic for vim
sudo rm -f /usr/bin/get_tmux_status.sh
sudo ln ./get_tmux_status.sh /usr/bin/get_tmux_status.sh
