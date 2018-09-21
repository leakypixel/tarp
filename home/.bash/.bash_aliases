# Git scripts
alias create='bash ~/bash-scripts/git-create-branch.sh'
alias delete='bash ~/bash-scripts/git-delete-branch.sh'
alias bac='bash ~/bash-scripts/git-branch-and-commit-changes.sh'
alias eradicate='bash ~/bash-scripts/remove-from-git-history.sh'
alias cleanup='bash ~/bash-scripts/clean-branches-that-dont-exist-on-remote.sh'
alias setauthor='bash ~/bash-scripts/change-git-author.sh'

# Other scripts
alias replace='bash ~/bash-scripts/replace.sh'
alias uniqify='bash ~/bash-scripts/uniqueify.sh'
alias fast='bash ~/bash-scripts/set-high-priority.sh'
alias brn='~/bash-scripts/bulk-rename.sh'

# Some nicer aliases for frequent commands
alias notes='vim ~/notes/'
alias sp='vim ~/notes/scratchpads/scratchpad-$(date +"%m-%d-%Y-%T")'
alias please='sudo'
alias s='sudo'
alias j='jump'
alias e='vim'
alias g='git'
alias gr='grunt'
alias gu='gulp'
alias rl='source ~/.bashrc'
alias xclip='xclip -selection c'
alias c='cless'
alias jsh='jshint **/*.js'
alias ufm='git stash && git checkout master && git pull && git checkout - && git rebase master'
alias upd='git stash && git checkout master && git pull && git fetch --prune && bash ~/bash-scripts/clean-branches-that-dont-exist-on-remote.sh'
alias dc='docker-compose'
alias owf='vim $(git status -s | grep -Po "(?<=^[ A-Z?][ A-Z?] ).*$")'


# Kill all docker containers that're up
alias dk='~/bash-scripts/bring-all-docker-machines-down.sh'

# Aliases because I'd likely have to google every time I wrote the command
alias tree='find . -not -path "*/\.*" | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'

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
