#!/bin/bash
# Make a directory and cd into it
mkcd () { mkdir "$@" && cd "$@" || return; }

# Colourise less
cless () { /usr/bin/src-hilite-lesspipe.sh "$@" | less -R; }

# Open all matching files in vim
vomit () {
  local pattern="${1:-}"
  local search_root="${2:-.}"
  local files=()

  if [ -z "$pattern" ]; then
    echo "Usage: vomit <pattern> [path]" >&2
    return 1
  fi

  mapfile -t files < <(grep -rl --exclude-dir={node_modules,.git,dist} -- "$pattern" "$search_root")
  if [ "${#files[@]}" -eq 0 ]; then
    echo "No files matched."
    return 1
  fi

  vim "${files[@]}"
}

# Delete saved vim session
rmsession () { rm "$HOME/.vim/sessions$PWD/session.vim" && echo "CWD vim session deleted."; }

# Run in current dir npm bin
npm-do () {
  local npm_bin
  npm_bin="$(npm bin 2>/dev/null)" || return 1
  (PATH="$npm_bin:$PATH" "$@")
}

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
