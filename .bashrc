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
    export GIT_PAGER='less -ri'

    alias gs='git status'
    alias gad='git add'
    alias gb='git branch '
    alias gc='git checkout --force'
    alias gd='git diff'
    alias gbl='git blame'
    alias gf='git fetch -p'
    alias gp='git pull origin'

    export LS_OPTIONS='-lah'
    alias ll='ls $LS_OPTIONS'

    alias tmux='TERM=screen-256color-bce tmux -2'
    alias vim='vim -c "e ++ff=unix"'
    alias less='less -ri'
    alias pr='ps waux | grep'
    alias gtree='git log --graph --full-history --all --color --pretty=format:"%x1b[33m%h%x09%x09%x1b[32m%d%x1b[0m %x1b[34m%an%x1b[0m   %s" "$@"'
    alias fb='git branch -a | egrep -i'
    alias ft='git tag | egrep -i'
    alias last_n='ls -lath | head'

    pstrace()
    {
        ps auxw | fgrep -i "$1" | fgrep -v "fgrep" | awk '{print"-p " $2}' | xargs sudo strace -v -ttt -f ${*:2} 2>&1
    }

    hdump()
    {
        hexdump -C $1 | less
    }

    num_avg() {
        awk '{ sum += $1 } END { if (NR > 0) print sum / NR }'
    }

    num_median() {
        sort -n | awk '{ a[i++]=$1; } END { print a[int(i/2)]; }'
    }

    num_avg_median() {
        sort -n | awk '{ a[i++]=$1; sum += $1; } END {for(x=1;x<=NR;x++){sumsq+=((a[x]-(sum/NR))**2);}} END { print "median: " a[int(i/2)] ", avg: " sum / NR ", n: " NR ", stdev: " sqrt(sumsq/NR) }'
    }

    md() { mkdir -p "$@" && cd "$@"; }

    agrep()
    {
      egrep -r -i --exclude=tags --color=always --exclude=./tags --binary-files=without-match "$@" . | less -ri
#fgrep -r -i --color=always --binary-files=without-match --exclude="*/tags" "$@" . | less -ri
    }

    cgrep()
    {
        egrep -r -i --color=always --include="*.[hc]" "$@" . | less -ri
#fgrep -r -i --color=always --include="*.{c,cc,cpp,h,cpp}" "$@" . | less -ri
    }

    cppgrep()
    {
        egrep -r -i --color=always --include="*.[hc]pp" "$@" . | less -ri
    }


    hppgrep()
    {
        egrep -r -i --color=always --include="*.hpp" "$@" . | less -ri
    }

    md() { mkdir -p "$@" && cd "$@"; }

    gl()
    {
        git log --decorate=full --stat --show-signature --color=always $@ | less -ri
    }

    glp()
    {
        git log --decorate=full --stat --show-signature -p --color=always $@ | less -ri
    }

    hgrep()
    {
        egrep -r -i --color=always --include=*.h "$@" . | less -ri
#fgrep -r -i --color=always --include="*.{h,hpp}" "$@" . | less -ri
    }
    
    xsgrep()
    {
        egrep -r -i --color=always --include=*.xs "$@" . | less -ri
    }

    pmgrep()
    {
        egrep -r -i --color=always --include=*.p[lm] "$@" . | less -ri
    }

    ggrep()
    {
        git grep -i "$@"
    }

    run() {
        number=$1
        shift
        for i in `seq $number`; do
            echo "$i: '$@'"
            $@ || break
        done
    }

    transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
        tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://t.bk.ru/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://t.bk.ru/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

    export MANPAGER="sh -c \"col -b | view -c 'set ft=man nomod nolist titlestring=MANPAGE' -\""

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
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/d.isaev/bin:/usr/local/git/bin:$HOME/go/bin
export PATH=$PATH:/Users/denis-isaev/Library/Python/2.7/bin:/usr/local/go/bin:/Users/denis-isaev/yandex-cloud/bin
export PATH="/usr/local/opt/curl-openssl/bin:$PATH"
ulimit -c unlimited
export CLICOLOR=1
alias executer='EXECUTER_CONF=/Users/denis-isaev/.executer.conf /usr/bin/perl /usr/local/bin/executer'
alias psql=/Applications/Postgres.app/Contents/Versions/latest/bin/psql
