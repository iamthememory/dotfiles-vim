#!/bin/sh

# Bootstrap Vim.

if command -v vim >/dev/null 2>&1
then
  # Try to install vim_bridge for python.
  for pip in pip pip2 pip3
  do
    if command -v "$pip" >/dev/null 2>&1
    then
      "$pip" install --user vim_bridge
    fi
  done

  # Add Vundle and clone the plugins.
  if [ -e ~/.vim/bundle/Vundle.vim ]
  then
    (
      cd ~/.vim/bundle/Vundle.vim
      git pull
    )
  else
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi

  vim +PluginInstall +qall
fi
