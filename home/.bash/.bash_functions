# Make a directory and cd into it
mkcd () { mkdir "$@" && cd "$@"; }

# Colourise less
cless () { /usr/bin/src-hilite-lesspipe.sh "$@" | less -R; }

# Open all matching files in vim
vomit () { vim $(grep -rl "$1" "$2"); }

# Set tmux window name
function sn () {
  if [ -z "$1" ]; then
    name=$(basename $PWD)
  else
    name=$1
  fi
  tmux rename-window "$name"
}
