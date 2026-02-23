#!/usr/bin/env bash
set -euo pipefail

basedir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
file_list="$basedir/config/index"
old_dotfiles_dir="$HOME/tmp/dotfiles-old"

while IFS= read -r file || [ -n "$file" ]; do
  [ -z "$file" ] && continue
  case "$file" in
    \#*) continue ;;
  esac

  target="$HOME/$file"
  source_path="$basedir/home/$file"

  if [ ! -L "$target" ]; then
    if [ -e "$target" ]; then
      mkdir -p "$old_dotfiles_dir"
      echo "Moving existing $file to ~/tmp/ - merge manually if required."
      mv "$target" "$old_dotfiles_dir/"
    fi
    if [ -e "$source_path" ]; then
      echo "Creating symlink to $file in home directory."
      mkdir -p "$(dirname "$target")"
      ln -s "$source_path" "$target"
    else
      echo "You have $file in the index, but it does not exist in the repository."
    fi
  fi
done <"$file_list"
