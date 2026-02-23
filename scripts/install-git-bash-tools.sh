#!/usr/bin/env bash
set -euo pipefail

install_dir="${1:-$HOME/.local/share/tarp/git}"
completion_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
prompt_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"

download() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$output"
    return
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -qO "$output" "$url"
    return
  fi

  echo "Neither curl nor wget is installed; cannot download $url" >&2
  exit 1
}

mkdir -p "$install_dir"
download "$completion_url" "$install_dir/git-completion.bash"
download "$prompt_url" "$install_dir/git-prompt.sh"

echo "Installed git shell helpers to $install_dir"
echo "Reload your shell or run: source ~/.bashrc"
