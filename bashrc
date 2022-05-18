source $HOME/.bash_aliases

# Constants
export CLICOLOR=1
export HISTFILESIZE=2500
export PATH="\
/usr/local/bin:\
/usr/local/sbin:\
~/bin:\
$PATH:\
/usr/local/share/npm/bin:\
~/.local/share/gem/ruby/3.0.0/bin\
"
# /Constants

# Miscellaneous utility functions
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

# Open the browser with Github's Pull Request form
pr() {
  to_branch=$1
  if [ -z $to_branch ]; then
    to_branch=$(git parent)
  fi

  origin=$(current_git_repo_upstream) 
  to_user=$(echo $origin | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
  from_user=$(echo $origin | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
  repo=$(echo $origin | sed -e 's/.*[^/]*\/\([^/]*\)\.git$/\1/')
  from_branch=$(git rev-parse --abbrev-ref HEAD)
  firefox "https://github.com/$to_user/$repo/pull/new/$to_user:$to_branch...$from_user:$from_branch"
}
current_git_repo_upstream() {
  # try the upstream branch if possible, otherwise origin will do
  upstream=$(git config --get remote.upstream.url)
  origin=$(git config --get remote.origin.url)
  if [ -z $upstream ]; then
    upstream=$origin
  fi

  echo $upstream
}
# current_git_repo_base_branch() {
#   LANG=en git remote show $(current_git_repo_upstream) | sed -n '/HEAD branch/s/.*: //p'
# }
# /Miscellaneous utility functions

case $OSTYPE in
  darwin*)
    os=mac
    ;;
  linux*)
    os=linux
    ;;
  *)
    exit ".bashrc says: Fucking $OSTYPE is not an OS known to me."
    ;;
esac

# Git subcommand aliasing
# Slightly modified from https://gist.github.com/mwhite/6887990
# Aliases defined in ~/.gitconfig
if [[ $os == 'mac' ]]
then
  . /usr/local/etc/bash_completion.d/git-completion.bash
elif [[ $os == 'linux' ]]
then
  . /usr/share/bash-completion/bash_completion
  # Load git functions like __git_aliased_command and __git_complete to
  # be used below
  . /usr/share/bash-completion/completions/git
fi

function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

git_aliases=`git --list-cmds=alias`
for al in $git_aliases; do
  alias g$al="git $al"
    
  complete_func=_git_$(__git_aliased_command $al)
  complete_func=${complete_func/-/_}
  function_exists $complete_func && __git_complete g$al $complete_func
done
# /Git subcommand aliasing

# Bash prompt config
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) != "" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
function error_exit_status {
  last_exit_status="$?";

  if [[ $last_exit_status != 0 ]]; then
    echo $last_exit_status
  fi
}
exit_status='\[\033[1;31m\]$(error_exit_status)'
time='\[\033[0;42m\]\t'
working_dir='\[\033[0;33m\] \w'
git_branch='\[\033[01;00m\]$(parse_git_branch): '
export PS1=$exit_status$time$working_dir$git_branch
# export PS1='\[\033[31m\]$(error_exit_status)\[\033[32m\]\t \[\033[0;33m\]\w\[\033[00m\]\[\033[01;00m\]$(parse_git_branch): '
# /Bash prompt config

# OS specific additions
sources=($HOME/werkbank/dotfiles/$os"_additions"/bash*)
for file in "${sources[@]}"
do
  source $file
done
# /OS specific additions

# Init utilities
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [[ -x $(which rbenv) ]]; then
  eval "$(rbenv init -)"
fi
# /Init utilities

[ -f ~/.aboutsourcerc ] && source ~/.aboutsourcerc
