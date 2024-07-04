#!/usr/bin/env bash

set -e

uNames=`uname -s`
osName=${uNames: 0: 4}

VERSION="3.30.0"

if [ "$osName" == "Darw" ]
  then
    echo "Mac OS X"
    # 源码安装
    DIR=cmake-$VERSION
    wget https://github.com/Kitware/CMake/releases/download/v$VERSION/cmake-$VERSION.tar.gz
    tar -zxvf cmake-$VERSION.tar.gz
    pushd $DIR
    ./bootstrap
    make -j$(nproc)
    sudo make install
    cmake --version
    popd
    rm -rf $DIR
elif [ "$osName" == "Linu" ]
  then
    echo "GNU/Linux"
    # 二进制安装
    rm -rf cmake-$VERSION-linux-x86_64.tar.gz
    wget https://github.com/Kitware/CMake/releases/download/v$VERSION/cmake-$VERSION-linux-x86_64.tar.gz
    tar -zxvf cmake-$VERSION-linux-x86_64.tar.gz
    sudo cp -r cmake-$VERSION-linux-x86_64/bin/* /usr/local/bin
    sudo cp -r cmake-$VERSION-linux-x86_64/doc/* /usr/local/doc
    sudo cp -r cmake-$VERSION-linux-x86_64/share/* /usr/local/share
    rm -rf cmake-$VERSION-linux-x86_64
    rm -rf cmake-$VERSION-linux-x86_64.tar.gz
    cmake --version
    else
  echo "unknown os :" $osName
  exit 8
fi
