# Make a directory and cd into it
mkcd () { mkdir "$@" && cd "$@"; }

# Colourise less
cless () { /usr/share/source-highlight/src-hilite-lesspipe.sh "$@" | less -R; }

# Open all matching files in vim
vomit () { vim $(grep -rl "$1" "$2"); }

# set an ad-hoc GUI timer (from
# https://bbs.archlinux.org/viewtopic.php?id=101805)
timer() {
  local N=$1; shift

  (sleep $N && zenity --info --title="Time's up" --text="${*:-BING}") &
  echo "timer set for $N" 
}
