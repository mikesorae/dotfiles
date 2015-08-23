#!/bin/sh

set -eux

cwd=`dirname $0`

if [ ! -e ~/.tmuxinator ] && [ ! -L ~/.tmuxinator ]; then
  ln -s "$cwd"/.tmuxinator ~/.tmuxinator
fi

if [ ! -e ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
  ln -s "$cwd"/.zshrc ~/.zshrc
fi
