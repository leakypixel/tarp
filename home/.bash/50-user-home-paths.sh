#!/bin/bash
# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

append_path() {
  local path_dir="$1"

  [ -d "$path_dir" ] || return 0
  case ":$PATH:" in
    *":$path_dir:"*) ;;
    *) PATH="$PATH:$path_dir" ;;
  esac
}

# Binaries in path
append_path "$HOME/.local/bin"

# Scripts in path
append_path "$HOME/scripts"

export PATH
unset -f append_path
