#!/bin/bash

node_package_list=$HOME/tarp/config/node-packages

if [ $(which npm) ]; then
  while read package; do
    if [ ! $(which $package) ]; then
      sudo npm install -g $package
    fi
  done<$node_package_list
fi
