#!/bin/bash
# Start ssh-agent if not started, grab variables if it is
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-cookie
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-cookie)" > /dev/null
fi


