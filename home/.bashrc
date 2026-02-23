# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Let the terminal emulator provide TERM (e.g. alacritty).
if [ -z "${TERM:-}" ]; then
  export TERM=xterm-256color
fi

unset PROMPT_COMMAND
while IFS= read -r module; do
  source "$module"
done < <(find "$HOME/.bash/" -name "*.sh" -type f | sort)
unset module
