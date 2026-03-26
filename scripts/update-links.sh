#!/usr/bin/env bash
set -euo pipefail

basedir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
file_list="$basedir/config/index"
local_file_list="$basedir/config/local/index"
old_dotfiles_dir="$HOME/tmp/dotfiles-old"
local_override_home="$basedir/config/local/home"
local_override_root="$basedir/config/local"

index_files=("$file_list")
if [ -r "$local_file_list" ]; then
  index_files+=("$local_file_list")
fi

backup_target_file() {
  local file="$1"
  local target="$2"
  local backup_path="$old_dotfiles_dir/$file"

  mkdir -p "$(dirname "$backup_path")"
  echo "Moving existing $file to $backup_path - merge manually if required."
  mv "$target" "$backup_path"
}

resolve_source_path() {
  local file="$1"
  local candidate

  for candidate in \
    "$local_override_home/$file" \
    "$local_override_root/$file" \
    "$basedir/home/$file"
  do
    if [ -e "$candidate" ] || [ -L "$candidate" ]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  return 1
}

declare -A seen_files=()

for active_file_list in "${index_files[@]}"; do
  while IFS= read -r file || [ -n "$file" ]; do
    [ -z "$file" ] && continue
    case "$file" in
      \#*) continue ;;
    esac

    if [ -n "${seen_files[$file]:-}" ]; then
      continue
    fi
    seen_files["$file"]=1

    target="$HOME/$file"
    source_path="$(resolve_source_path "$file" || true)"

    if [ -z "$source_path" ]; then
      echo "You have $file in the index, but it does not exist in home/ or config/local/."
      continue
    fi

    if [ -L "$target" ]; then
      current_link="$(readlink "$target")"
      if [ "$current_link" = "$source_path" ]; then
        continue
      fi

      echo "Updating symlink target for $file."
      ln -sfn "$source_path" "$target"
      continue
    fi

    if [ -e "$target" ]; then
      backup_target_file "$file" "$target"
    fi

    echo "Creating symlink to $file in home directory."
    mkdir -p "$(dirname "$target")"
    ln -s "$source_path" "$target"
  done <"$active_file_list"
done
