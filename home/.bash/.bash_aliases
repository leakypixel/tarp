# Git scripts
alias create='bash ~/bash-scripts/git-create-branch.sh'
alias delete='bash ~/bash-scripts/git-delete-branch.sh'
alias eradicate='bash ~/bash-scripts/remove-from-git-history.sh'
alias cleanup='bash ~/bash-scripts/clean-branches-that-dont-exist-on-remote.sh'
alias setauthor='bash ~/bash-scripts/change-git-author.sh'

# Other scripts
alias replace='bash ~/bash-scripts/replace.sh'
alias uniqify='bash ~/bash-scripts/uniqueify.sh'
alias fast='bash ~/bash-scripts/set-high-priority.sh'

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
alias jsh='jshint **/*.js'
alias ufm='git checkout master && git pull && git checkout - && git merge master'
alias upd='git checkout master && git pull && git fetch --prune && bash ~/bash-scripts/clean-branches-that-dont-exist-on-remote.sh'

# Aliases because I'd likely have to google every time I wrote the command
alias tree='find . -not -path "*/\.*" | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'

# temp
alias nano='echo "did you mean: vim"'
alias gs='echo "stop fucking typing it without a space!"'
