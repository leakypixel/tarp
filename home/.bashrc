# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set UTF-8
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"
export LANGUAGE="en_GB.UTF-8"

# Set history location
export HISTFILE=$HOME/.bash/.bash_history

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colours on
export TERM=screen-256color

# Base16 Shell
BASE16_SHELL="$HOME/.bash/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL


# If we're not already tmuxed, be tmuxed
if [ -z "$TMUX" ]; then
  # Connect to a tmux session if one already exists, otherwise make a new one (set in tmux config).
  tmux attach
fi

# Set vim as the editor for just about everything
export VISUAL="vim"
export EDITOR="vim"
export DIFFTOOL="vim"

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
  test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
if [ -f $HOME/.bash/.bash_aliases ]; then
  . $HOME/.bash/.bash_aliases
fi

# Function definitions.
if [ -f $HOME/.bash/.bash_functions ]; then
  . $HOME/.bash/.bash_functions
fi

# RVM/Ruby
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.gem/ruby/2.2.0/bin"

# Android
export PATH=${PATH}:$HOME/android-sdk-linux/tools
export PATH=${PATH}:$HOME/android-sdk-linux/platform-tools

# NodeJS/NPM
export PATH="$PATH:/usr/bin/npm"
export PATH=/home/craigf/.node/bin:$PATH

# Load NVM for node version management
export NVM_DIR="/home/craigf/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Binaries in path
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/home/craigf/.local/bin"

# Fuck (best-guess last incorrect command, pip install thefuck)
alias fuck='$(thefuck $(fc -ln -1))'

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

