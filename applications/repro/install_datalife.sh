#!/bin/sh
ROOTDIR=$PWD
set -e
module load gcc-native/13.2
mkdir datalife_bin
python -m venv datalife_venv
source datalife_venv/bin/activate

git clone https://github.com/pnnl/datalife.git
cd datalife
git apply ../datalife.patch

mkdir build
cd build
cmake \
  -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
  -DCMAKE_INSTALL_PREFIX=$ROOTDIR/datalife_bin \
  ..
make install -j8
