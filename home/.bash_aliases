# Git scripts
alias create='bash ~/bash-scripts/git-create-branch.sh'
alias delete='bash ~/bash-scripts/git-delete-branch.sh'
alias eradicate='bash ~/bash-scripts/remove-from-git-history.sh'
alias cleanup='bash ~/bash-scripts/clean-branches-that-dont-exist-on-remote.sh'
alias setauthor='bash ~/bash-scripts/change-git-author.sh'

# Scripts
alias replace='bash ~/bash-scripts/replace.sh'
alias fast='bash ~/bash-scripts/set-high-priority.sh'
alias force-backup='bash ~/tarp/backup.sh'

# Some nicer aliases for frequent commands
alias please='sudo'
alias s='sudo'
alias j='jump'
alias e='vim'
alias g='git'
alias gr='grunt'
alias gu='gulp'
alias rl='source ~/.bashrc'
alias xclip='xclip -selection c'
alias ufm='git checkout master && git pull && git checkout - && git merge master'

# temp
alias nano='echo "did you mean: vim"'
alias gs='echo "stop fucking typing it without a space!"'
