./update_dotfiles.sh

STATUS_FILE="./status.txt"

VUNLDE_INST_DIR=~/.vim/bundle/Vundle.vim
if [ ! -d "$VUNLDE_INST_DIR" ]; then
    echo "install Vundle"
    git clone https://github.com/gmarik/Vundle.vim.git $VUNLDE_INST_DIR
fi

if python -mplatform | grep -qi ubuntu; then
    echo "install ubuntu packages"
    CMD="sudo apt-get install -y vim exuberant-ctags npm build-essential cmake python-dev clang-3.7 libclang-3.7-dev"
    eval $CMD || { sudo apt-get update; eval $CMD; }
else
    echo "os isn't ubuntu"
fi

vim +PluginInstall +qall || { echo "can't install vim plugins"; exit 1; }

if [ ! -f ~/.vim/colors/solarized.vim ]; then
    mkdir -p ~/.vim/colors
    ln ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/solarized.vim
fi

echo "install jslint..."
npm list -g jslint || sudo npm install -g jslint # for syntastic for vim

sudo rm -f /usr/local/bin/get_tmux_status.sh
sudo ln ./get_tmux_status.sh /usr/local/bin/get_tmux_status.sh

git clone https://github.com/dracula/iterm.git ~/dracula-theme-iterm
echo "Dracula theme was downloaded, use it in iTerm2 > Preferences > Profiles > Colors Tab -> Color Presets -> Import"
