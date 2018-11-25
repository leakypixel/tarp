# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set UTF-8
#export LC_ALL="en_GB.UTF-8"
#export LANG="en_GB.UTF-8"
#export LANGUAGE="en_GB.UTF-8"

# Set history location
export HISTFILE=$HOME/.bash/.bash_history

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colours on, set termtype
#export TERM=screen-256color
#export TERM=vt100
export TERM=xterm

# Set vim as the editor for just about everything
export VISUAL="vim"
export EDITOR="vim"
export DIFFTOOL="vim"
# ...including in bash! :D
set -o vi

# enable color support of ls
#if [ -x /usr/bin/dircolors ]; then
#  test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
#fi

# Alias definitions.
if [ -f $HOME/.bash/.bash_aliases ]; then
  . $HOME/.bash/.bash_aliases
fi

# Function definitions.
if [ -f $HOME/.bash/.bash_functions ]; then
  . $HOME/.bash/.bash_functions
fi

# GoLang
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# RVM/Ruby
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#export PATH="$PATH:$HOME/.gem/ruby/2.2.0/bin"

# Android
#export PATH=${PATH}:$HOME/android-sdk-linux/tools
#export PATH=${PATH}:$HOME/android-sdk-linux/platform-tools

# NodeJS/NPM
export PATH="$PATH:/usr/bin/npm"

# Load NVM for node version management
source /usr/share/nvm/init-nvm.sh

# Binaries in path
export PATH="$PATH:/home/leakypixel/.local/bin"

# Bash scripts in path
export PATH="$PATH:/home/leakypixel/bash-scripts"

# Marking of directories, and jumping to them - script from http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
if [ -f $HOME/.bash/mark-jump.sh ]; then
  source $HOME/.bash/mark-jump.sh
fi

# Set some colour variables
if [ -f $HOME/.bash/color-variables.bash ]; then
  source $HOME/.bash/color-variables.bash
fi

# Set git prompt
if [ -f $HOME/.bash/git-prompt.sh ]; then
  source $HOME/.bash/git-prompt.sh
fi

# Set git completion
if [ -f $HOME/.bash/git-completion.sh ]; then
  source $HOME/.bash/git-completion.sh
fi

# Add ntfy auto notify on long command complete
eval "$(ntfy shell-integration)"
export AUTO_NTFY_DONE_IGNORE="ssh vim screen dc docker-compose"

# Start ssh-agent if not started, grab variables if it is
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-cookie
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-cookie)" > /dev/null
fi
