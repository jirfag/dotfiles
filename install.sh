set -x

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
elif python -mplatform | grep -qi darwin; then
    echo "installing mac os packages"
    if ! fgrep -qi .bashrc ~/.bash_profile; then
        echo 'source ~/.bashrc' >>~/.bash_profile
    fi
    which brew
    if test $? -ne 0; then
        set +x
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        set -x
    else
        brew update
    fi

    brew install tmux
else
    echo "os isn't ubuntu"
fi

vim +PluginInstall +qall || { echo "can't install vim plugins"; exit 1; }

git clone https://github.com/dracula/iterm.git ~/dracula-theme-iterm
echo "Dracula theme was downloaded, use it in iTerm2 > Preferences > Profiles > Colors Tab -> Color Presets -> Import"

# https://github.com/tmux-plugins/tpm

test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
