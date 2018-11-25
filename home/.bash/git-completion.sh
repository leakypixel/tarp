#!/bin/bash
# Git completion

function set_git_completion {
  # Add git completion to my custom 'g' alias.
  __git_complete g __git_main
}

if [ -f /usr/share/git/completion/git-completion.bash ]; then
  source /usr/share/git/completion/git-completion.bash
  set_git_completion
else
  sudo mkdir -p /usr/share/git/completion
  sudo wget -O /usr/share/git/completion/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
  if [ -f /usr/share/git/completion/git-completion.bash ]; then
    source /usr/share/git/completion/git-completion.bash
    set_git_completion
  else
    echo "Could not load git completion :("
  fi
fi
