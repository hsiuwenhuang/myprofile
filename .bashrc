# System-wide .bashrc file for interactive bash(1) shells.
# Last Update:2014/11/16 02:17:23

function chtitle {

    echo -n -e "\033]0;$1\007"
}

# prompt for git status
function git_branch {

ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
remote=$(git remote -v | grep fetch | tail -n1 | cut -d '	' -f1)
commit=$(git log --pretty=format:'%h' -n 1)
if [ -n $remote ];then
    echo -e "($remote/"${ref#refs/heads/}"/\033[1;32m$commit\033[m) ";
    #echo -e "($remote/"${ref#refs/heads/}") ";
else
    echo "("${ref#refs/heads/}"/\033[1;32m$commit\033[m) ";
    #echo "("${ref#refs/heads/}") ";
fi
}

function git_since_last_commit {

    now=`date +%s`;

    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;

    seconds_since_last_commit=$((now-last_commit));

    minutes_since_last_commit=$((seconds_since_last_commit/60));

    hours_since_last_commit=$((minutes_since_last_commit/60));

    if [ $hours_since_last_commit -lt 1 ]; then

        echo "${minutes_since_last_commit}m";

    else

        days_since_last_commit=$((hours_since_last_commit/24));

        hours_since_last_commit=$((hours_since_last_commit%24));

        minutes_since_last_commit=$((minutes_since_last_commit%60));

        if [ $days_since_last_commit -lt 1 ]; then

            echo "${hours_since_last_commit}h${minutes_since_last_commit}m";

        else

            echo "${days_since_last_commit}d ${hours_since_last_commit}h ${minutes_since_last_commit}m";

        fi

    fi
}

function new_ticket {
    if [[ -z "$1" ]] ;then
        echo "No ticket number specified!";
    else
        echo "git push origin master:ticket$1";
        git push origin master:ticket$1;
    fi
}

function got_ticket {
    if [[ -z "$1" ]] ;then
        echo "No ticket number specified!";
    else
        echo "git checkout ticket$1";
        git checkout ticket$1;
    fi
}

function new_tag {

    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    branch=${ref#refs/heads/};

    if [ "$branch" != "master" ]; then
        echo "Not in master";
        echo "checkout master";
        git checkout master
    fi

    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    new_branch=${ref#refs/heads/};

    if [ "$new_branch" != "master" ]; then
        echo "Checkout master failed!";
        return;
    fi

    if [[ -z "$1" ]];then
        echo "No ticket number specified!";
    else
        echo "git tag -a before$1";
        git tag before$1 -m bofore$1;
        echo "git push origin before$1";
        git push origin before$1;
    fi
}

# locale setting

export LC_ALL=zh_TW.UTF-8

export EDITOR=/usr/bin/vim

PS1="\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;34m\]\h\[\033[00m\]:\[\033[01;34m\]\W \t\[\033[00m\]\n\$(git_branch)\[\033[0;33m\]\$(git_since_last_commit)\[\033[0m\] ➤ "

# Make bash check its window size after a process completes
shopt -s checkwinsize

os=$(uname)

if [ $os == "Linux" ];then
    alias ls='ls -F --color=always'
else
    alias ls='ls -GF'
fi

alias d='ls'
alias dl='ls -lht'
alias dla='ls -alht'
alias dal='dla'
alias da='ls -a'
#alias s="screen -e '\`~'"
alias s="screen -e '\`~'"
alias sr="screen -e '\`~' -r"
alias sx="screen -e '\`~' -x"

alias t='tmux'
alias ta='tmux attach'

alias slab='ssh 140.138.176.201'
alias sirl='ssh -p 17320 70640-serve@irl.ee.yzu.edu.tw'
alias sjccf='ssh jccf.com.tw'
alias saqua='ssh aqua.srv.pixnet'
alias sirc=' mosh --ssh="ssh -p 222" irc.pixnet.tw'
alias :q='echo "You are now in bash not in VIM!!!";exit'
set -o emacs
set -o ignoreeof
alias grep='grep --color=always '

# C-W rease word till slash
stty werase undef
bind '"\C-w":backward-kill-word'

alias grep='grep --color=always '
alias work='cd ~/work'
