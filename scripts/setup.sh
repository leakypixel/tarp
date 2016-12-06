#!/usr/bin/env bash

basedir=$HOME/tarp
cd $basedir

$basedir/scripts/install-system-packages.sh
$basedir/scripts/create-directories.sh

git submodule init
git submodule up

$basedir/scripts/update-links.sh
$basedir/scripts/install-node-packages.sh
