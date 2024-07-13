#!/usr/bin/env bash
#
TMUX_VERSION="3.4"

uNames=`uname -s`
osName=${uNames: 0: 4}

set -e

if [ "$osName" == "Linu" ]
  then
    echo "GNU/Linux"
    sudo apt remove tmux
    sudo apt install -y bison flex libevent-dev libncurses5-dev
elif [ "$osName" == "Darw" ]
  then
    echo "macOS"
    brew install libevent
fi

installed_tmux_version=$(tmux -V 2>/dev/null | sed 's/tmux //')

if command -v tmux &> /dev/null; then
  if [ "$installed_tmux_version" == "$TMUX_VERSION" ]; then
    echo "tmux version $TMUX_VERSION is already installed."
    exit 0
  else
    echo "tmux version $installed_tmux_version is installed. Installing version $TMUX_VERSION..."
  fi
fi

wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz

tar -zxvf tmux-${TMUX_VERSION}.tar.gz

cd tmux-${TMUX_VERSION}

# Mac M1 ./configure --enable-utf8proc (https://github.com/minhanghuang/env/issues/9)
./configure

make -j$(nproc) && sudo make install

cd .. && rm -rf tmux-${TMUX_VERSION} tmux-${TMUX_VERSION}.tar.gz

## 安装tmux tpm
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    if [ -z "$(ls -A $TPM_DIR)" ]; then
        echo "Directory exists but is empty. Cloning TPM..."
        git clone https://github.com/tmux-plugins/tpm $TPM_DIR
    else
        echo "Directory is not empty. No action needed."
    fi
else
    echo "Directory does not exist. Cloning TPM..."
    git clone https://github.com/tmux-plugins/tpm $TPM_DIR
fi

echo "tmux ${TMUX_VERSION} 安装完成！"
