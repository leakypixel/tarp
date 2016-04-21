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
