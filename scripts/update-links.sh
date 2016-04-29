#!/usr/bin/env bash

basedir=$HOME/tarp
cd $basedir

while read file; do
  if [ ! -L $HOME/$file ]; then
    if [ -e $HOME/$file ]; then
      echo "Moving existing $file to ~/tmp/ - merge manually if required."
      mv $HOME/$file $HOME/tmp/
    fi
    if [ -e $basedir/home/$file ]; then
      echo "Creating symlink to $file in home directory."
      ln -s $basedir/home/$file $HOME/$file
    else
      echo "You have $file in the index, but it does not exist in the repository."
    fi
  fi
done <$basedir/index
