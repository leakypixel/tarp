#!/bin/bash
# NodeJS/NPM
# Load NVM for node version management.
if [ -r "/usr/share/nvm/init-nvm.sh" ]; then
  # shellcheck source=/dev/null
  source "/usr/share/nvm/init-nvm.sh"
elif [ -r "$HOME/.nvm/nvm.sh" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.nvm/nvm.sh"
fi
