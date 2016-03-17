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
function set_git_prompt {
  # Git bash prompt
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWUPSTREAM=auto

  #PS1="\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ "
  #PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
  PS1="\[$Yellow\][\[$Reset\]\t \u \[$White\]\w\[$BCyan\]\$(__git_ps1 ' (%s)')\[$Yellow\]]\[$Reset\]\$ "
}

# Now test if we already have git completion and prompt scripts, if not then try a few likely places and get them if needs be.
# Git prompt
if [ -z __git_ps1 ]; then
  set_git_prompt
else
  if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    source /usr/share/git/completion/git-prompt.sh
    set_git_prompt
  else
    sudo mkdir -p /usr/share/git/completion
    sudo wget -O /usr/share/git/completion/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    if [ -f /usr/share/git/completion/git-prompt.sh ]; then
      source /usr/share/git/completion/git-prompt.sh
      set_git_prompt
    else
      echo "Could not load git prompt :("
    fi
  fi
fi
