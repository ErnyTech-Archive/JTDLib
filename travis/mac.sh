#!/bin/bash

# Build deps
brew update
brew upgrade
brew install gperf

# Dirs
cd src/main/jni
mkdir build
mkdir $TRAVIS_BUILD_DIR/out
cd build

# Setup env
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))

# Build
cmake -DTD_ENABLE_JNI=ON  -DCMAKE_INSTALL_PREFIX:PATH=. -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl/ ..
cmake --build . --target install

# Copy artifacts
cp bin/libtdjni.dylib $TRAVIS_BUILD_DIR/out
