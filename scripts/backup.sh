#!/bin/bash

basedir=$HOME/tarp
cd $basedir

# Add submodules to index
# Loop through all the non-git directories in my configs
for i in $(find $basedir/home/ -type d -not -path "**/.git/**" -not -path "**/.git");
do
  # Check for a .git directory, if it exists, add it as a submodule
  gitdir="$i"/.git
  if [ -d "$gitdir" ]; then
    echo $gitdir
    # Get the remote url from the repo
    remote=$(git --git-dir="$gitdir" remote -v show -n origin | grep "Fetch URL" | grep -ow '[^ ]*\.git$')
    # Git submodules don't like absolute paths, so strip it down to something git-friendly
    relpath=$(echo $i | sed 's|'$basedir'/|./|')
    # Finally, add it using the remote and relative path we generated above
    git submodule add $remote $relpath
  fi
done

# Push via git
echo Committing and pushing everything via git...
cd $basedir
git add -A
git commit -m "Auto backup"
git push origin
