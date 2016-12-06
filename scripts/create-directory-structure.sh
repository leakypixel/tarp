#!/bin/bash
directory_list="$HOME/tarp/config/directories"

while read directory; do
  dir=$(eval echo \"$directory\")
  mkdir -p $dir
done<$directory_list
