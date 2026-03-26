#!/bin/bash
# RVM/Ruby
append_path() {
  local path_dir="$1"

  [ -d "$path_dir" ] || return 0
  case ":$PATH:" in
    *":$path_dir:"*) ;;
    *) PATH="$PATH:$path_dir" ;;
  esac
}

append_path "$HOME/.rvm/bin"
append_path "$HOME/.gem/ruby/2.6.0/bin"
append_path "$HOME/.gem/ruby/3.0.0/bin"

if [ -s "$HOME/.rvm/scripts/rvm" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.rvm/scripts/rvm"
fi

export PATH
unset -f append_path
