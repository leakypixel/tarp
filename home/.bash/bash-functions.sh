#!/bin/bash
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

# Run a command on all my pis via ssh
allpis () { 
  pis="bathroom-pi bedroom-pi back-room-pi hallway-pi main-room-pi"
  for host in ${pis[@]}; do
    ssh pi@$host "$1" &
  done
  wait
}
