#!/usr/bin/env bash
#
set -e

# 执行当前脚本
# wget -qO- https://raw.githubusercontent.com/minhanghuang/env/dev/setup/ubuntu.libs.sh | bash

UBUNTU_VERSION=$(lsb_release -rs)
IFS='.' read -r MAJOR_VERSION MINOR_VERSION <<< "$UBUNTU_VERSION"
MAJOR_VERSION=${MAJOR_VERSION%.*}
echo "当前Ubuntu版本: $MAJOR_VERSION"

sudo apt update

# install base
sudo apt install -y \
  build-essential openssh-server net-tools libtool sudo iputils-ping libgsl-dev ntpdate \
  python3-pip python3-venv axel silversearcher-ag lsof unzip nfs-common libevent-dev

# install C++ dependence
sudo apt install -y \
  pkg-config autoconf automake cmake make ninja-build g++ gdb cgdb clang-format \
  llvm bear valgrind apport

# install tools
sudo apt install -y htop chrony tig tree libunwind-dev curl unzip wget baobab xclip

# install pulgin
sudo apt install -y zsh git vim nodejs global cppman
if [ "$MAJOR_VERSION" -gt 18 ]; then
  # Ubuntu18以上
  sudo apt install -y yarn neofetch
  sudo apt install -y ripgrep universal-ctags
fi

# install porxy
sudo apt install -y supervisor nginx

# install language
sudo apt install -y locales language-pack-zh-hans
sudo locale-gen en_US.UTF-8 zh_CN.UTF-8

if dpkg -l | grep -q "ubuntu-desktop" || dpkg -l | grep -q "gnome-shell"; then
  echo "Ubuntu Desktop"
else
  echo "Ubuntu Server"
fi

# nfs-common: nfs目录挂载
# baobab: 查看磁盘占用GUI
# ripgrep: 全文搜索工具
# universal-ctags global: 源代码导航和标签生成的工具
# neofetch: 查看系统信息
# cppman: 查看C++ 98/11/14/17/20 manual pages
# apport: 解压crash文件
# valgrind: 查看C++程序内存泄露工具
# xclip: 剪切板工具
