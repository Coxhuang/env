#!/usr/bin/env bash

set -e

# 执行当前脚本
# wget -qO- https://raw.githubusercontent.com/minhanghuang/env/dev/setup/python.sh | bash

PYTHON_VERSION="3.8.10"

wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz

tar -zxvf Python-$PYTHON_VERSION.tgz

# 安装到/usr/bin
cd Python-$PYTHON_VERSION && ./configure --prefix=/usr --enable-shared

make -j$(nproc) && sudo make install

sudo ln -sf /usr/bin/python3.8 /usr/bin/python3
