#!/usr/bin/env bash

basedir=$HOME/tarp
file_list=$HOME/tarp/config/index
old_dotfiles_dir=$HOME/tmp/dotfiles-old

while read file; do
  if [ ! -L $HOME/$file ]; then
    if [ -e $HOME/$file ]; then
      mkdir -p $old_dotfiles_dir
      echo "Moving existing $file to ~/tmp/ - merge manually if required."
      mv $HOME/$file $old_dotfiles_dir
    fi
    if [ -e $basedir/home/$file ]; then
      echo "Creating symlink to $file in home directory."
      ln -s $basedir/home/$file $HOME/$file
    else
      echo "You have $file in the index, but it does not exist in the repository."
    fi
  fi
done <$file_list
