#!/bin/sh

set -eux

cwd=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


if [ ! -e ~/.tmuxinator ] && [ ! -L ~/.tmuxinator ]; then
  ln -s "$cwd"/.tmuxinator ~/.tmuxinator
fi

if [ ! -e ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
  ln -s "$cwd"/.zshrc ~/.zshrc
fi

if [ ! -e ~/.vimrc ] && [ ! -L ~/.vimrc ]; then
  ln -s "$cwd"/.vimrc ~/vimrc
fi
