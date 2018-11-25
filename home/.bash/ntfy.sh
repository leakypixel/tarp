#!/bin/bash
# Add ntfy auto notify on long command complete
eval "$(ntfy shell-integration)"
export AUTO_NTFY_DONE_IGNORE="ssh vim screen dc docker-compose"


