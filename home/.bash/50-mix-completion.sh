#!/usr/bin/env bash
_mix_completions()
{
  COMPREPLY=($(compgen -W "$(mix help | sed 's/^mix //; s/ .*$//g; s/^iex$//' | paste -sd " " -)" "${COMP_WORDS[1]}"))
}

complete -F _mix_completions mix
