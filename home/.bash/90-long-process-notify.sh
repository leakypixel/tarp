#!/bin/bash
# Threshold in seconds (default: 10 if not set)
: "${LONG_JOB_THRESHOLD:=10}"

# Internal timer variable
__long_job_last_seconds=$SECONDS

__long_job_check() {
    local exit_status=$?
    local now=$SECONDS
    local duration=$(( now - __long_job_last_seconds ))

    if (( duration >= LONG_JOB_THRESHOLD )) && [ -x "$HOME/scripts/shell-notify" ]; then
      "$HOME/scripts/shell-notify" "Complete: $(fc -ln -0 | awk '{$1=$1; print}')" complete
    fi

    __long_job_last_seconds=$now
    return $exit_status
}

PROMPT_COMMAND="__long_job_check${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
