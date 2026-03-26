#!/bin/bash
export ANDROID_HOME="${ANDROID_HOME:-/opt/android-sdk}"

append_path() {
  local path_dir="$1"

  [ -d "$path_dir" ] || return 0
  case ":$PATH:" in
    *":$path_dir:"*) ;;
    *) PATH="$PATH:$path_dir" ;;
  esac
}

append_path "$ANDROID_HOME/tools"
append_path "$ANDROID_HOME/platform-tools"
export PATH

unset -f append_path
