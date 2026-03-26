#!/bin/bash
# GoLang
export GOPATH="${GOPATH:-$HOME/dev/go}"

append_path() {
  local path_dir="$1"

  [ -d "$path_dir" ] || return 0
  case ":$PATH:" in
    *":$path_dir:"*) ;;
    *) PATH="$PATH:$path_dir" ;;
  esac
}

if [ -n "${GOROOT:-}" ]; then
  append_path "$GOROOT/bin"
fi
append_path "$GOPATH/bin"

export PATH
unset -f append_path

