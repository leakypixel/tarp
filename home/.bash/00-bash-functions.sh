#!/bin/bash
# Make a directory and cd into it
mkcd () { mkdir "$@" && cd "$@"; }

# Colourise less
cless () { /usr/bin/src-hilite-lesspipe.sh "$@" | less -R; }

# Open all matching files in vim
vomit () { vim $(grep -rl --exclude-dir={node_modules,.git} "$1" "$2"); }

# Delete saved vim session
rmsession () { rm "$HOME/.vim/sessions$PWD/session.vim" && echo "CWD vim session deleted."; }

# Run in current dir npm bin
npm-do () { (PATH=$(npm bin):$PATH; eval $@;) }

function sp { 
  scratchpad="scratchpad-$(date +"%d-%m-%Y-%T").md"
  scratchpath="$HOME/notes_private/scratchpads/"
  vim "$scratchpath$scratchpad"
  read -rp $'Rename (n, d or name)?\n' choice
  case "$choice" in
    d|D ) rm "$scratchpath$scratchpad";;
    n|N ) echo "$scratchpad";;
    * ) mv "$scratchpath$scratchpad" "$scratchpath$choice" && echo "$scratchpath$choice";;
  esac
}
