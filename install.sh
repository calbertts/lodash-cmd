printf "\n  Downloading lodash-cmd...\n\n"

platform=`uname -s`
distro=`cat /etc/*-release 2>/dev/null | grep ^ID=[A-Za-z]* | sed s/ID=/-/g | sed s/\"//g`
arch=`uname -m`

install() {
  if which_lodashcmd="$(command -v _)"; then
    printf "\n  lodash-cmd (_) is already installed\n\n"
    printf "\n  Try with:\n  \e[92m_ get \"'dependencies.@babel/code-frame.version'\" \\ \n    --url https://raw.githubusercontent.com/lodash/lodash/master/package-lock.json\n\n\e[0m"
  else
    mkdir -p ~/.calbertts_tools
    PATH="$PATH:$HOME/.calbertts_tools"
    
    echo "Source: https://github.com/calbertts/lodash-cmd/releases/latest/download/lodash-cmd-$platform$distro-$arch"
    curl -sL -o _ github.com/calbertts/lodash-cmd/releases/latest/download/lodash-cmd-$platform$distro-$arch
    chmod a+x _
    mv _ ~/.calbertts_tools
    ln -s ~/.calbertts_tools/_ /usr/local/bin/_ 2>/dev/null
    export PATH
    echo "export PATH=\"\$PATH:\$HOME/.calbertts_tools\"" >> ~/.bashrc

    if which_lodashcmd="$(command -v _)"; then
      printf "\n  Great!, now reload your shell with: source ~/.bashrc\n\n  Try with:\n  \e[92m_ get \"'dependencies.@babel/code-frame.version'\" \\ \n    --url https://raw.githubusercontent.com/lodash/lodash/master/package-lock.json\n\n\e[0m"
    else
      printf "\n  Turns out there was an error installing lodash-cmd (_), try it again\n"
    fi
  fi
}

install
