function inst() {
    echo "cp $1 ~/$1"
    test -f ~/$1 && rm -f ~/$1.bak && mv ~/$1 ~/$1.bak
    cp $1 ~/$1 || { echo "can't do cp"; exit 1; }
}

inst .bashrc
inst .gitconfig
inst .tmux.conf
inst .vimrc
inst .git-prompt.sh

# colorize ls output
if echo "$(uname -a)" | grep -qi Darwin; then
    echo "export CLICOLOR=1" >>~/.bashrc
else
    echo "alias ll='ls $LS_OPTIONS --color=auto'" >>~/.bashrc
fi
