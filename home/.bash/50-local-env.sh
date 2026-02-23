#!/bin/bash

if [ -n "${_TARP_LOCAL_ENV_BOOTSTRAPPED:-}" ]; then
  return
fi
export _TARP_LOCAL_ENV_BOOTSTRAPPED=1

__tarp_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
__tarp_repo_root="$(cd "$__tarp_script_dir/../.." && pwd -P)"
__tarp_env_root="$__tarp_repo_root/config/local/env"
__tarp_default_env_file="$__tarp_env_root/default"
__tarp_active_dir_env_file=""
__tarp_last_pwd=""
__tarp_active_dir_env_vars=()
declare -A __tarp_dir_env_previous_values=()
declare -A __tarp_dir_env_had_value=()

mkdir -p "$__tarp_env_root"

__tarp_source_env_file() {
  local env_file="$1"
  local allexport_was_set=0

  if [ ! -r "$env_file" ]; then
    return 1
  fi

  case $- in
    *a*) allexport_was_set=1 ;;
  esac

  set -a
  # shellcheck source=/dev/null
  source "$env_file"
  if [ "$allexport_was_set" -eq 0 ]; then
    set +a
  fi
}

__tarp_extract_env_var_names() {
  local env_file="$1"
  local line

  while IFS= read -r line || [ -n "$line" ]; do
    if [[ "$line" =~ ^[[:space:]]*# ]] || [[ "$line" =~ ^[[:space:]]*$ ]]; then
      continue
    fi
    if [[ "$line" =~ ^[[:space:]]*export[[:space:]]+([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*(=.*)?$ ]]; then
      printf '%s\n' "${BASH_REMATCH[1]}"
      continue
    fi
    if [[ "$line" =~ ^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*= ]]; then
      printf '%s\n' "${BASH_REMATCH[1]}"
    fi
  done < "$env_file" | awk '!seen[$0]++'
}

__tarp_dir_env_file_for_abs_dir() {
  local abs_dir="$1"

  if [ "$abs_dir" = "/" ]; then
    printf '%s/.env\n' "$__tarp_env_root"
  else
    printf '%s%s/.env\n' "$__tarp_env_root" "$abs_dir"
  fi
}

__tarp_find_nearest_dir_env_file() {
  local abs_dir="$1"
  local candidate

  while true; do
    candidate="$(__tarp_dir_env_file_for_abs_dir "$abs_dir")"
    if [ -f "$candidate" ]; then
      printf '%s\n' "$candidate"
      return 0
    fi
    if [ "$abs_dir" = "/" ]; then
      break
    fi
    abs_dir="$(dirname "$abs_dir")"
  done

  return 1
}

__tarp_unload_active_dir_env() {
  local var_name

  for var_name in "${__tarp_active_dir_env_vars[@]}"; do
    if [ "${__tarp_dir_env_had_value[$var_name]:-0}" -eq 1 ]; then
      printf -v "$var_name" '%s' "${__tarp_dir_env_previous_values[$var_name]}"
      export "$var_name"
    else
      unset "$var_name"
    fi
    unset "__tarp_dir_env_previous_values[$var_name]"
    unset "__tarp_dir_env_had_value[$var_name]"
  done

  __tarp_active_dir_env_vars=()
  __tarp_active_dir_env_file=""
}

__tarp_load_dir_env_file() {
  local env_file="$1"
  local var_name
  local parsed_var_names=()

  mapfile -t parsed_var_names < <(__tarp_extract_env_var_names "$env_file")
  for var_name in "${parsed_var_names[@]}"; do
    if [ "${!var_name+set}" = "set" ]; then
      __tarp_dir_env_had_value["$var_name"]=1
      __tarp_dir_env_previous_values["$var_name"]="${!var_name}"
    else
      __tarp_dir_env_had_value["$var_name"]=0
      unset "__tarp_dir_env_previous_values[$var_name]"
    fi
  done

  __tarp_source_env_file "$env_file" || return 1
  __tarp_active_dir_env_vars=("${parsed_var_names[@]}")
  __tarp_active_dir_env_file="$env_file"
}

__tarp_refresh_dir_env() {
  local abs_dir
  local next_env_file=""

  abs_dir="$(pwd -P 2>/dev/null)" || abs_dir="$PWD"
  if [ "$abs_dir" = "$__tarp_last_pwd" ]; then
    return 0
  fi
  __tarp_last_pwd="$abs_dir"

  next_env_file="$(__tarp_find_nearest_dir_env_file "$abs_dir" 2>/dev/null)" || next_env_file=""
  if [ "$next_env_file" = "$__tarp_active_dir_env_file" ]; then
    return 0
  fi

  __tarp_unload_active_dir_env
  if [ -n "$next_env_file" ]; then
    __tarp_load_dir_env_file "$next_env_file"
  fi
}

__tarp_local_env_prompt_hook() {
  local exit_status=$?
  __tarp_refresh_dir_env
  return "$exit_status"
}

# localenv [default|path [dir]|dir]
localenv() {
  local mode="${1:-here}"
  local target_dir="$PWD"
  local abs_dir
  local env_file

  if [ "$mode" = "-h" ] || [ "$mode" = "--help" ]; then
    echo "Usage: localenv [default|path [dir]|dir]"
    echo "  localenv              # create/edit env for current directory"
    echo "  localenv /path/to/dir # create/edit env for a specific directory"
    echo "  localenv default      # create/edit default env file"
    echo "  localenv path [dir]   # print env file path for directory"
    return 0
  fi

  if [ "$mode" = "default" ]; then
    env_file="$__tarp_default_env_file"
    mkdir -p "$(dirname "$env_file")"
    [ -f "$env_file" ] || printf '# Loaded in every shell.\n' > "$env_file"
    "${VISUAL:-${EDITOR:-vim}}" "$env_file"
    return
  fi

  if [ "$mode" = "path" ]; then
    if [ "${2:-}" = "default" ]; then
      echo "$__tarp_default_env_file"
      return 0
    fi
    target_dir="${2:-$PWD}"
  elif [ "$mode" != "here" ]; then
    target_dir="$mode"
  fi

  abs_dir="$(cd "$target_dir" 2>/dev/null && pwd -P)" || {
    echo "localenv: directory not found: $target_dir" >&2
    return 1
  }

  env_file="$(__tarp_dir_env_file_for_abs_dir "$abs_dir")"
  if [ "$mode" = "path" ]; then
    echo "$env_file"
    return 0
  fi

  mkdir -p "$(dirname "$env_file")"
  [ -f "$env_file" ] || printf '# Loaded when in %s (or child dirs).\n' "$abs_dir" > "$env_file"
  "${VISUAL:-${EDITOR:-vim}}" "$env_file"
}

if [ -r "$__tarp_default_env_file" ]; then
  __tarp_source_env_file "$__tarp_default_env_file"
fi
__tarp_refresh_dir_env

case ";${PROMPT_COMMAND:-};" in
  *";__tarp_local_env_prompt_hook;"*) ;;
  *) PROMPT_COMMAND="__tarp_local_env_prompt_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}" ;;
esac

unset __tarp_script_dir __tarp_repo_root
