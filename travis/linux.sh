#!/bin/bash

# Build deps
sudo add-apt-repository ppa:openjdk-r/ppa
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update -qq
sudo apt-get upgrade
sudo apt-get install gcc-8 g++-8 make gperf openjdk-11 cmake libssl-dev

# Dirs
cd src/main/jni
mkdir build
mkdir $TRAVIS_BUILD_DIR/out
cd build

# Setup env
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
export CC=/usr/bin/gcc-8
export CXX=/usr/bin/g++-8

# Build
cmake -DTD_ENABLE_JNI=ON -DCMAKE_INSTALL_PREFIX:PATH=. ..
cmake --build . --target install

# Copy artifacts
cp -rf * $TRAVIS_BUILD_DIR/out
