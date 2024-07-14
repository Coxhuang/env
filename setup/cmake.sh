#!/usr/bin/env bash

set -e

VERSION="3.22.0"

uNames=`uname -s`
osName=${uNames: 0: 4}
uArch=$(uname -m)

echo uNames

if [ "$osName" == "Darw" ]
  then
    echo "Mac OS X"
    # 源码安装
    DIR=cmake-$VERSION
    if [ ! -e cmake-$VERSION.tar.gz ]; then
        wget https://github.com/Kitware/CMake/releases/download/v$VERSION/cmake-$VERSION.tar.gz
    fi
    tar -zxvf cmake-$VERSION.tar.gz
    cd $DIR
    ./bootstrap
    make $(($(nproc) - 1))
    sudo make install
    cmake --version
    cd .. && rm -rf $DIR cmake-$VERSION.tar.gz
elif [ "$osName" == "Linu" ]
  then
    echo "GNU/Linux"
    # 二进制安装
    rm -rf cmake-$VERSION-linux-$uArch.tar.gz
    wget https://github.com/Kitware/CMake/releases/download/v$VERSION/cmake-$VERSION-linux-$uArch.tar.gz
    tar -zxvf cmake-$VERSION-linux-$uArch.tar.gz
    sudo cp -r cmake-$VERSION-linux-$uArch/bin/* /usr/local/bin
    sudo cp -r cmake-$VERSION-linux-$uArch/doc/* /usr/local/doc
    sudo cp -r cmake-$VERSION-linux-$uArch/share/* /usr/local/share
    rm -rf cmake-$VERSION-linux-$uArch
    rm -rf cmake-$VERSION-linux-$uArch.tar.gz
    cmake --version
else
  echo "unknown os :" $osName
  exit 8
fi
