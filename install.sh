STATUS_FILE="./status.txt"

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

VUNLDE_INST_DIR=~/.vim/bundle/Vundle.vim
if [ ! -d "$VUNLDE_INST_DIR" ]; then
    echo "install Vundle"
    git clone https://github.com/gmarik/Vundle.vim.git $VUNLDE_INST_DIR
fi

if echo "$(uname -a)" | grep -qi ubuntu; then
    echo "install ubuntu packages"
    CMD="sudo apt-get install -y vim exuberant-ctags npm build-essential cmake python-dev clang-3.7 libclang-3.7-dev"
    eval $CMD || { sudo apt-get update; eval $CMD; }
fi

vim +PluginInstall +qall || { echo "can't install vim plugins"; exit 1; }

if [ ! -f ~/.vim/colors/solarized.vim ]; then
    mkdir -p ~/.vim/colors
    ln ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/solarized.vim
fi

if [ -f ~/.vim/bundle/YouCompleteMe/install.sh ]; then
    if ! grep -q ycm $STATUS_FILE; then
        echo "install YCM core"
        (cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer --system-libclang)
        echo ycm >>$STATUS_FILE
    fi
else
    echo "YCM wasn't installed"
    exit 1
fi

echo "install jslint..."
npm list -g jslint || sudo npm install -g jslint # for syntastic for vim

sudo rm -f /usr/bin/get_tmux_status.sh
sudo ln ./get_tmux_status.sh /usr/bin/get_tmux_status.sh
