#!/bin/bash

# These are the prerequisite packages and directories, held here so this script
# can be pulled and run without needing to clone the whole repo first (which
# would require git).
packages="git tmux vim albert conky stalonetray google-chrome-stable nvm npm rvm"
directories="tmp dev"

if [ -n "$packages" ]; then
  # This needs rewriting, but currently works for ubuntu systems so I'll leave it for now.
  function install {
    # deb
    if [ $(which apt-get) ]; then
      sudo apt-get update
      for package in $1; do
        sudo apt-get install -y $package
      done
    # arch
    elif [ $(which pacman) ]; then
      sudo pacman -Syu
      for package in $1; do
        sudo pacman -S --noconfirm $package
      done
    else
    # nobody uses fedora :trollface:
      echo "Couldn't find package manager :("
      exit
    fi
  }

  for package in $packages; do
    if [ $(which $package) ]; then
      echo $package already installed.
    else
      packages_to_install+=" $package"
    fi
  done

  if [ -n "$packages_to_install" ]; then
    echo Installing: $packages_to_install
    for package in $packages_to_install; do
      install $package
    done
  fi
fi

cd

if [ -n "$directories" ]; then
  for dir in $directories; do
    mkdir -p $dir
  done
fi


git clone https://github.com/leakypixel/tarp.git

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
git submodule update

git branch $HOSTNAME && git checkout $HOSTNAME && git push -u origin $HOSTNAME

cd

echo Done setup.
