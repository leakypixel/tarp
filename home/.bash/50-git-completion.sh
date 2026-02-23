#!/bin/bash
# Git completion

set_git_completion() {
  # Add git completion to my custom 'g' alias.
  if declare -F __git_complete >/dev/null 2>&1; then
    __git_complete g __git_main
  fi
}

_git_completion_script=""
for candidate in \
  "$HOME/.local/share/tarp/git/git-completion.bash" \
  "/usr/share/git/completion/git-completion.bash"
do
  if [ -f "$candidate" ]; then
    _git_completion_script="$candidate"
    break
  fi
done

if [ -n "$_git_completion_script" ]; then
  # shellcheck source=/dev/null
  source "$_git_completion_script"
  set_git_completion
else
  echo "git-completion.bash not found. Run: $HOME/tarp/scripts/install-git-bash-tools.sh"
fi

unset _git_completion_script
