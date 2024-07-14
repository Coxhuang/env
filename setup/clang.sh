#!/usr/bin/env bash

set -e

VERSION="16.0.2"

uNames=`uname -s`
osName=${uNames: 0: 4}
uArch=$(uname -m)

echo uNames

if [ "$osName" == "Linu" ]
  then
    echo "GNU/Linux" $uArch
  if [ "$uArch" == "aarch64" ]
    then
      echo "arch: " $uArch
      wget https://github.com/llvm/llvm-project/releases/download/llvmorg-$VERSION/clang+llvm-$VERSION-$uArch-linux-gnu.tar.xz
      tar -xvf clang+llvm-$VERSION-$uArch-linux-gnu.tar.xz
      sudo cp -r clang+llvm-$VERSION-$uArch-linux-gnu/* /usr/local
  else
      echo "arch: " $uArch
  fi
else
  echo "unknown os :" $osName $uArch
  exit 8
fi

