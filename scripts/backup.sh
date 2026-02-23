#!/usr/bin/env bash
set -euo pipefail

basedir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$basedir"

# Add nested git repositories under home/ as submodules.
while IFS= read -r -d '' gitdir; do
  repo_dir="$(dirname "$gitdir")"
  relpath="./${repo_dir#"$basedir"/}"
  submodulepath="${relpath#./}"

  remote="$(git -C "$repo_dir" config --get remote.origin.url || true)"
  if [ -z "$remote" ]; then
    echo "Skipping $repo_dir (no origin remote)."
    continue
  fi

  if git config -f .gitmodules --get-regexp '^submodule\..*\.path$' 2>/dev/null | awk '{print $2}' | grep -Fxq "$submodulepath"; then
    continue
  fi

  echo "Adding submodule $submodulepath -> $remote"
  git submodule add "$remote" "$relpath"
  git config -f .gitmodules "submodule.$submodulepath.ignore" untracked
done < <(find "$basedir/home" -type d -name .git -print0)

# Push via git
echo "Committing and pushing everything via git..."
git add -A
if git diff --cached --quiet; then
  echo "No changes to commit."
else
  git commit -m "Auto backup"
  git push origin
fi
