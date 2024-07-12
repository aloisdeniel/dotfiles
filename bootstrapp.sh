#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git pull origin main

function doIt() {
  # Copies all of the files to home directory
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude ".osx" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "LICENSE" \
    -avh --no-perms . ~

  # Install all programs
  source ~/install.sh
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt
