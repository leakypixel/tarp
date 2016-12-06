#!/bin/bash

system_package_list=$HOME/tarp/config/system-packages

# This needs rewriting, but currently works for ubuntu systems so I'll leave it for now.
function system_install {
  # deb
  if [ $(which apt-get) ]; then
    # don't communicate with apt directly - it sometimes returns an exit code
    # before it's actually finished (when installing dependencies).
    yes | sudo aptdcon --hide-terminal --install "$1"
  # arch
  elif [ $(which pacman) ]; then
    sudo pacman -S --noconfirm $1
  else
  # nobody uses fedora :trollface:
    echo "Couldn't find package manager :("
    exit
  fi
}

while read package; do
  if [ $(which $package) ]; then
    echo $package already installed.
  else
    system_install $package
  fi
done<$system_package_list
