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

  # (Re)build YouCompleteMe.
  olddir="$(pwd)"
  cd "${HOME}/.vim/bundle/YouCompleteMe"
  echo "YCM: Including CLANG support"
  ycmlangs="--clang-completer"

  if check_command xbuild
  then
    echo "YCM: Not including C# support by default"
    #ycmlangs="${ycmlangs} --omnisharp-completer"
  else
    echo "YCM: xbuild needed for C# support"
  fi

  if check_command go
  then
    echo "YCM: Including Go support"
    ycmlangs="${ycmlangs} --gocode-completer"
  else
    echo "YCM: go needed for Go support"
  fi

  if check_command node && check_command npm
  then
    echo "YCM: Including JavaScript support"
    ycmlangs="${ycmlangs} --tern-completer"

    if check_command tsserver
    then
      echo "YCM: tsserver found"
    else
      echo "YCM: Installing typescript locally"
      npm install --prefix "${HOME}/.local" -g typescript
    fi
  else
    echo "YCM: node.js and npm needed for JavaScript support"
    echo "YCM: node.js and npm needed for TypeScript support"
  fi

  if check_command rustc && check_command cargo
  then
    echo "YCM: Including Rust support"
    ycmlangs="${ycmlangs} --racer-completer"
  else
    echo "YCM: rustc and cargo needed for Rust support"
  fi

  # Build.
  ./install.py $ycmlangs
  cd "$olddir"
fi
