#!/usr/bin/env bash

basedir=~/tarp

cd $basedir

files=$(find $basedir/home/ -maxdepth 1 -not -type l -not -name 'home' -printf "%f ")


for file in $files; do
  echo "Moving existing $file to ~/tmp/ - merge manually if required."
  mv ~/$file ~/tmp/$file
  echo "Creating symlink to $file in home directory."
  ln -s $basedir/home/$file ~/$file
done

git submodule init
git submodule up

git clone https://github.com/leakypixel/default-configs.git $HOME/default-configs
rm -rf $HOME/default-configs/.git
rsync -avh $HOME/default-configs $HOME/.config
rm -rf $HOME/default-configs
