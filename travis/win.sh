#!/bin/bash

# Vcpkg
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
powershell .\bootstrap-vcpkg.bat
powershell .\vcpkg integrate install
powershell .\vcpkg install zlib:x64-windows-static openssl:x64-windows-static
cd $TRAVIS_BUILD_DIR

# Build deps
choco install gperf 
choco install jdk8 -params 'installdir=c:\\java8'

# Dirs
cd src/main/jni
mkdir build
mkdir $TRAVIS_BUILD_DIR/out
cd build

# Setup env
export JAVA_HOME="c:\\java8"

# Build
cmake -DTD_ENABLE_JNI=ON  -DCMAKE_INSTALL_PREFIX:PATH=. -DCMAKE_TOOLCHAIN_FILE=$TRAVIS_BUILD_DIR\vcpkg\scripts\buildsystems\vcpkg.cmake ..
cmake --build . --target install

# Copy artifacts
cp bin/libtdjni.dll $TRAVIS_BUILD_DIR/out
