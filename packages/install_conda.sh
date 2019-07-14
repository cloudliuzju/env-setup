#!/usr/bin/env bash

if [ -z $COMMON_SOURCED ]; then
  source include/common.sh
fi

if [ -z $SYSTEM_VARIABLES_SOURCED ]; then
  source include/system_variables.sh
fi

export TMP_DIR=/tmp
export MINICONDA_INSTALL_DIR=$HOME/miniconda3

case $OS_TYPE in
  Linux*)
    export MINICONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    ;;
  Darwin*)
    export MINICONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    ;;
  *)
    echo "OS $OS_TYPE is not supported"
esac

install_miniconda() {
  pushd ${TMP_DIR}
  if [[ ! -f "miniconda.sh" ]]; then
      wget ${MINICONDA_URL} -O miniconda.sh
  fi
  chmod +x miniconda.sh
  ./miniconda.sh -b -p $MINICONDA_INSTALL_DIR
  popd
}

set_conda_mirror() {
  conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
  conda config --set show_channel_urls yes
}

confirm install_miniconda "Install miniconda3"
confirm set_conda_mirror "Setup china mirror for conda"
