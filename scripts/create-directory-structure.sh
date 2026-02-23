#!/usr/bin/env bash
set -euo pipefail

basedir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
directory_list="$basedir/config/directories"

while IFS= read -r directory || [ -n "$directory" ]; do
  [ -z "$directory" ] && continue
  case "$directory" in
    \#*) continue ;;
  esac

  dir="${directory//\$HOME/$HOME}"
  mkdir -p "$dir"
done <"$directory_list"
