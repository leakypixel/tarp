# Make a directory and cd into it
mkcd () { mkdir "$@" && cd "$@"; }

# Colourise less
cless () { /usr/bin/src-hilite-lesspipe.sh "$@" | less -R; }

# Open all matching files in vim
vomit () { vim $(grep -rl "$1" "$2"); }

# Delete saved vim session
rmsession () { rm "$HOME/.vim/sessions$PWD/session.vim" && echo "CWD vim session deleted."; }

# Run in current dir npm bin
npm-do () { (PATH=$(npm bin):$PATH; eval $@;) }
