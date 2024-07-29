#!/usr/bin/env bash

set -e

VERSION="18.19.0"
uNames=`uname -s`
osName=${uNames: 0: 4}


### install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if [ -n "$ZSH_VERSION" ]; then
  source ~/.zshrc
elif [ -n "$BASH_VERSION" ]; then
  source ~/.bashrc
else
  echo "无法确定shell类型。请手动source相应的配置文件。"
  exit 8
fi
nvm --version
nvm install $VERSION
nvm alias default $VERSION
node --version

if [ "$osName" == "Darw" ] # macOS
  then
    echo "Mac OS X"
    brew install yarn npm
    npm config set http://registry.npmmirror.com
    yarn config set registry http://registry.npmmirror.com
    yarn set version berry # update 4.x
elif [ "$osName" == "Linu" ] # Linux
  then
    echo "GNU/Linux"
    sudo apt update && sudo apt install -y npm
    npm config set https://registry.npmmirror.com
    # yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install -y yarn
    yarn set version berry # update 4.x
else
  echo "unknown os :" $osName
  exit 8
fi
