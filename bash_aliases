alias b='bundle'
alias be='bundle exec'
alias bo='bundle open'
alias bu='bundle update'
alias d=docker
alias dc=docker-compose
alias i='bundle exec rake i18n:js:export'
alias ll='ls -lah'
alias ls='ls -F'
alias lsd='/bin/ls -d1 */'
alias m='bundle exec rake db:migrate && bundle exec rake db:migrate RAILS_ENV=test'
alias p='ping db.de'
alias pse='ps -e | grep'
alias rm='rm -fr'
alias s='sudo'
alias t='cd /tmp'
alias vim='nvim -u ~/.vimrc'
alias w="cd $HOME/werkbank"
alias dus="du -sh"
alias dea='docker-compose exec app'
alias rd='rubocop $(git diff --name-only $(git parent) | grep "\.rb$\|\.rake$" | grep -v "db/schema.rb")'
alias rda='rubocop -a $(git diff --name-only $(git parent) | grep "\.rb$\|\.rake$" | grep -v "db/schema.rb")'

# Git aliases no autocompletable
# (adding them here if possible, saves shell startup time)
alias grc='git rebase --continue'
alias gaa='git add -A'
# list branches sorted by last modified
alias gbl="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
alias gbb='git bisect bad'
alias gbg='git bisect good'
alias gbk='git bisect skip'
alias gbr='git bisect reset'
alias gbs='git bisect start'
alias gs='git status -s'
alias gta='git stash apply'
alias gtp='git stash pop'
alias gp='git log -p -M --follow --stat --'
alias gcn='git clean -f'
alias gg='git git log --graph --format="%C(white)%h:%Creset %s (%C(cyan)%an, %ar%Creset)%d"'
alias gam='git commit --amend -C HEAD -a'
