source $HOME/.bash_profile_mac
source $HOME/.bash_aliases

__define_git_completion () {
eval "
    _git_$2_shortcut () {
        COMP_LINE=\"git $2\${COMP_LINE#$1}\"
        let COMP_POINT+=$((4+${#2}-${#1}))
        COMP_WORDS=(git $2 \"\${COMP_WORDS[@]:1}\")
        let COMP_CWORD+=1

        local cur words cword prev
        _get_comp_words_by_ref -n =: cur words cword prev
        _git_$2
    }
"
}

__git_shortcut () {
    type _git_$2_shortcut &>/dev/null || __define_git_completion $1 $2
    alias $1="git $2 $3"
    complete -o default -o nospace -F _git_$2_shortcut $1
}

__git_shortcut gc commit -m
__git_shortcut gca commit -am
__git_shortcut gps push
__git_shortcut gpl pull
__git_shortcut ga add
__git_shortcut gaa add -A
__git_shortcut gs status
__git_shortcut gl log
__git_shortcut glo log --oneline
__git_shortcut gd diff
__git_shortcut gr rebase
__git_shortcut go checkout
__git_shortcut gb branch
__git_shortcut gob checkout -b
__git_shortcut gh help
__git_shortcut gf fetch
__git_shortcut gm merge
__git_shortcut gt stash
__git_shortcut gtp stash pop
__git_shortcut gta stash apply
__git_shortcut gmt mergetool
__git_shortcut gcn clean -f
__git_shortcut grth reset --hard
__git_shortcut gbs bisect start
__git_shortcut gbg bisect good
__git_shortcut gbb bisect bad
__git_shortcut gbk bisect skip
__git_shortcut gbr bisect reset
__git_shortcut gw show

export POSTGRES=true
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
export PATH=$PATH:/usr/local/share/npm/bin

export PGDATA=/usr/local/var/postgres
source /usr/local/etc/bash_completion.d/git-completion.bash
T_PS1_SHOWDIRTYSTATE=true
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) != "" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PS1=' \[\033[0;33m\]\w\[\033[00m\]\[\033[01;00m\]$(parse_git_branch): ' #PS1='\w> '

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# makes lowercase HEAD available systems where it is not the default
git symbolic-ref head HEAD