#!/bin/sh
set -e
if [ -z "$CC" ]; then export CC="clang"; fi
if [ -z "$CXX" ]; then export CXX="clang++"; fi

# stdlibc++ has a bug in some versions (at least in Ubuntu 22.04, probably Debian 12 too) that will cause compilation to fail for Encore
# Debian 11's stdlibc++ is unaffected (and probably Ubuntu 20.04's too)
# Note that Debian 10's stdlibc++ is too old (nearly no c++20 support), so at least Debian 11 must be used to compile this core
# At least cmake 3.20 must be present too, so get cmake from bullseye-backports

rm -rf build
mkdir build
cd build
cmake ../encore -DCMAKE_BUILD_TYPE=Release -DENABLE_LTO=ON -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX \
 -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_CXX_FLAGS="-Wno-deprecated -include limits.h" -G Ninja
ninja
