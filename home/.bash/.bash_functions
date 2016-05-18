# Make a directory and cd into it
mkcd () { mkdir "$@" && cd "$@"; }

# Colourise less
cless () { /usr/share/source-highlight/src-hilite-lesspipe.sh "$@" | less -R; }

# Open all matching files in vim
vomit () { vim $(grep -rl "$1" "$2"); }
