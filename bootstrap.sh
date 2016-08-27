#!/bin/sh

check_command() {
  if command -v "$1" >/dev/null 2>&1
  then
    return 0
  else
    return 1
  fi
}

# Bootstrap Vim.

if check_command vim
then
  # Try to install vim_bridge for python.
  for pip in pip pip2 pip3
  do
    if check_command "$pip"
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
