
# .bashrc
source ~/.git-prompt.sh

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

    shopt -s histappend
    PROMPT_COMMAND='history -a'

    # User specific aliases and functions
    export LC_ALL=ru_RU.UTF8
    export LANG=ru_RU.UTF8
    export PATH=~/bin/:$PATH
    export GIT_PAGER='less -r'

    alias gs='git status'
    alias ga='git commit -a --amend'
    alias gb='git branch '
    alias gc='git checkout --force'
    alias gd='git diff'
    alias gbl='git blame'
    alias gf='git fetch -p'
    alias gp='git pull origin'
    alias ll='ls -l -a'
    alias tmux='TERM=screen-256color-bce tmux -2'
    alias vim='vim -c "e ++ff=unix"'
    alias less='less -r'
    alias pr='ps waux | grep'
    alias gtree='git log --graph --full-history --all --color --pretty=format:"%x1b[33m%h%x09%x09%x1b[32m%d%x1b[0m %x1b[34m%an%x1b[0m   %s" "$@"'
    alias fb='git branch -a | grep -i'
    alias last='ls -l -a -t | head -n'

    md() { mkdir -p "$@" && cd "$@"; }

    agrep()
    {
      egrep -r -i --exclude=tags --color=always --exclude=./tags --binary-files=without-match "$@" . | less -r
#fgrep -r -i --color=always --binary-files=without-match --exclude="*/tags" "$@" . | less -r
    }

    cgrep()
    {
        egrep -r -i --color=always --include="*.[hc]" "$@" . | less -r
#fgrep -r -i --color=always --include="*.{c,cc,cpp,h,cpp}" "$@" . | less -r
    }

    cppgrep()
    {
        egrep -r -i --color=always --include="*.[hc]pp" "$@" . | less -r
    }


    hppgrep()
    {
        egrep -r -i --color=always --include="*.hpp" "$@" . | less -r
    }

    md() { mkdir -p "$@" && cd "$@"; }

    gl()
    {
        git log -p --color=always $@ | less -r
    }

    hgrep()
    {
        egrep -r -i --color=always --include=*.h "$@" . | less -r
#fgrep -r -i --color=always --include="*.{h,hpp}" "$@" . | less -r
    }
    
    xsgrep()
    {
        egrep -r -i --color=always --include=*.xs "$@" . | less -r
    }

    pmgrep()
    {
        egrep -r -i --color=always --include=*.p[lm] "$@" . | less -r
    }
    
    ggrep()
    {
        git grep -i "$@"
    }

    export MANPAGER="col -b | view -c 'set ft=man nomod nolist' -"

    # Set git autocompletion and PS1 integration
   if [ -f /etc/bash_completion.d/git ]; then
     . /etc/bash_completion.d/git
     fi
     GIT_PS1_SHOWDIRTYSTATE=true

     if [ -f /opt/local/etc/bash_completion ]; then
         . /opt/local/etc/bash_completion
     fi

#PS1="\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]($(git branch | awk '{ print $2; }'))\[\033[00m\]\$ "
PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/d.isaev/bin:/usr/local/git/bin
