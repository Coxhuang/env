#!/usr/bin/env bash

set -e

VERSION="9.2"

uNames=`uname -s`
osName=${uNames: 0: 4}
uArch=$(uname -m)

echo uNames

if [ "$osName" == "Linu" ]
  then
    echo "GNU/Linux"
    wget https://ftp.gnu.org/gnu/gdb/gdb-$VERSION.tar.gz
    tar -xzf gdb-$VERSION.tar.gz
    cd gdb-$VERSION
    mkdir -p build && cd build
    sudo apt update && sudo apt install -y build-essential texinfo libncurses5-dev python3-dev
    ../configure --prefix=/usr/local
    make -j$(nproc)
    sudo make install
    sudo ln -sf /usr/local/bin/gdb /usr/bin/gdb
    rm -rf gdb-$VERSION.tar.gz gdb-$VERSION
else
  echo "unknown os :" $osName
  exit 8
fi
