#!/bin/sh
set -e

usage() {
  echo "Usage: cmake_linux.sh <gcc|clang|clang-libc++> <debug|release|reldeb>"
  exit 1
}

if [ "$#" -ne 2 ]; then
  usage
fi

case "$1" in
  gcc)
    export CXX="g++"
    export CC="gcc"
    DIRECTORY="gcc"
    ;;
  clang)
    export CXX="clang++"
    export CC="clang"
    DIRECTORY="clang"
    CMAKE_CXX_FLAGS="-stdlib=libstdc++"
    ;;
  clang-libc++)
    export CXX="clang++"
    export CC="clang"
    DIRECTORY="clang-libc++"
    CMAKE_CXX_FLAGS="-stdlib=libc++"
    ;;
  *)
    echo "Unknown compiler: $1"
    usage
    ;;
esac

case "$2" in
  debug)   BUILDTYPE="debug";          CMAKE_BUILD_TYPE="Debug" ;;
  release) BUILDTYPE="release";        CMAKE_BUILD_TYPE="Release" ;;
  reldeb)  BUILDTYPE="relwithdebinfo"; CMAKE_BUILD_TYPE="RelWithDebInfo" ;;
  *)
    echo "Unknown build type: $2"
    usage
    ;;
esac

if ! command -v ninja >/dev/null 2>&1; then
  echo "ERROR: ninja not found in PATH."
  exit 1
fi

BUILDDIR="build/$DIRECTORY/$BUILDTYPE"

mkdir -p "$BUILDDIR"
cd "$BUILDDIR"

cmake -G "Ninja" -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS" ../../../code