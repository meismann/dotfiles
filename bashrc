export BASH_PROFILE_RAN=1

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
__git_shortcut gps push -u
__git_shortcut gpsf push --force-with-lease
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
__git_shortcut gom checkout master
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
# https://blog.andrewray.me/a-better-git-blame/
__git_shortcut gp log -p -M --follow --stat --
__git_shortcut gdh diff HEAD

# Create dir and enter
mcd ()
{
  mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# cd to the bundled gem
bcd ()
{
  gem=$1
  cd $(bundle show $gem)
}

export POSTGRES=true
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
export PATH=$PATH:/usr/local/share/npm/bin
export HISTFILESIZE=2500
export PGDATA=/usr/local/var/postgres

if [[ -e /usr/local/etc/bash_completion.d/git-completion.bash ]]
then
  # for Mac:
  source /usr/local/etc/bash_completion.d/git-completion.bash
else
  # for linux:
  [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
fi

T_PS1_SHOWDIRTYSTATE=true
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) != "" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PS1='\e[42m$(date "+%H:%M:%S")\e[0m \[\033[0;33m\]\w\[\033[00m\]\[\033[01;00m\]$(parse_git_branch): '

# add OS specific additions
case $OSTYPE in
  darwin*)
    additions_dir='mac_additions'
    ;;
  linux*)
    additions_dir='linux_additions'
    ;;
  *)
    exit ".bashrc says: Fucking $OSTYPE is not an OS known to me."
    ;;
esac
sources=($HOME/werkbank/dotfiles/$additions_dir/bash*)
for file in "${sources[@]}"
do
  source $file
done

[ -e $HOME/.sagerc ] && source $HOME/.sagerc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Open the browser with Github's Pull Request form
pr() {
  to_branch=$1
  if [ -z $to_branch ]; then
    to_branch="master"
  fi

  # try the upstream branch if possible, otherwise origin will do
  upstream=$(git config --get remote.upstream.url)
  origin=$(git config --get remote.origin.url)
  if [ -z $upstream ]; then
    upstream=$origin
  fi

  to_user=$(echo $upstream | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
  from_user=$(echo $origin | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
  repo=$(echo $origin | sed -e 's/.*[^/]*\/\([^/]*\)\.git$/\1/')
  from_branch=$(git rev-parse --abbrev-ref HEAD)
  open "https://github.com/$to_user/$repo/pull/new/$to_user:$to_branch...$from_user:$from_branch"
}

eval "$(rbenv init -)"
