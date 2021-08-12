#!/bin/bash
# Git scripts
alias create='git-create-branch'
alias delete='git-delete-branch'
alias bac='git-branch-and-commit-changes'

# Some nicer aliases for frequent commands
alias notes='vim ~/notes/'
alias daily='vim ~/notes/daily.md'
alias please='sudo'
alias s='sudo'
alias j='jump'
alias g='git'
alias rl='source ~/.bashrc'
alias xclip='xclip -selection c'
alias ufm='git stash && git checkout master && git pull && git checkout - && git rebase master'
alias dc='docker-compose'
alias owf='vim $(git status -s | grep -Po "(?<=^[ A-Z?][ A-Z?] ).*$")'


# Kill all docker containers that're up
alias dk='~/scripts/bring-all-docker-machines-down'

# grep aliases to turn on colour
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases for colour and convenience
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Default mv to prompt before overwrite
alias mv='mv -i'
