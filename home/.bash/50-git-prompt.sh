#!/bin/bash
# Set up PS1 with git prompt etc.
# Various variables you might want for your PS1 prompt
Time12h="\T"
Time12a="\@"
Time24h="\t"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

# Function to actually set the prompt, called below once we've sourced our git prompt script.
set_git_prompt() {
  # Git bash prompt
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWUPSTREAM=auto

  #PS1="\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ "
  #PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
  PS1="\[$Reset\]\[$On_IYellow$Black\]\u\[$Reset\]\[$Blue\] \W \[$Reset$Cyan\]\$(__git_ps1 '(%s)')\[$Yellow\]\[$Reset\] \$ "
}

# Try local install first, then system install.
_git_prompt_script=""
if ! declare -F __git_ps1 >/dev/null 2>&1; then
  for candidate in \
    "$HOME/.local/share/tarp/git/git-prompt.sh" \
    "/usr/share/git/completion/git-prompt.sh"
  do
    if [ -f "$candidate" ]; then
      _git_prompt_script="$candidate"
      break
    fi
  done

  if [ -n "$_git_prompt_script" ]; then
    # shellcheck source=/dev/null
    source "$_git_prompt_script"
  fi
fi

if declare -F __git_ps1 >/dev/null 2>&1; then
  set_git_prompt
else
  echo "git-prompt.sh not found. Run: $HOME/tarp/scripts/install-git-bash-tools.sh"
  PS1="\u@\h \W \$ "
fi

unset _git_prompt_script
