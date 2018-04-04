#!/usr/bin/env bash

basedir=$HOME/tarp
cd $basedir

$basedir/scripts/create-directories.sh

git submodule init
git submodule up

$basedir/scripts/update-links.sh

branch_exists=$(git branch -a | grep -l `hostname`)
if [ -z "$branch_exists" ]; then
  git checkout -b `hostname`
else
  echo "Branch `hostname` exists."
fi
