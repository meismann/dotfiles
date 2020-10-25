export BASH_PROFILE_RAN=1

source $HOME/.bash_aliases

if [[ -e /usr/local/etc/bash_completion.d/git-completion.bash ]]
then
  # for Mac:
  source /usr/local/etc/bash_completion.d/git-completion.bash
else
  # for linux:
  . /usr/share/bash-completion/bash_completion
  # Load git functions
  . /usr/share/bash-completion/completions/git
fi

git_aliases=`git config --get-regexp ^alias\\. | sed -e s/^alias\\.// -e s/\\ .*$//`

function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

for al in $git_aliases; do
  alias g$al="git $al"
    
  complete_func=_git_$(__git_aliased_command $al)
  function_exists $complete_fnc && __git_complete g$al $complete_func
done

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

gcl ()
{
  git clone $1 && cd $(basename $_ .git)
}

export CLICOLOR=1
export POSTGRES=true
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
export PATH=$PATH:/usr/local/share/npm/bin
export HISTFILESIZE=2500
export PGDATA=/usr/local/var/postgres
export BASH_SILENCE_DEPRECATION_WARNING=1

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

if [[ -x $(which rbenv) ]]; then
  eval "$(rbenv init -)"
fi
