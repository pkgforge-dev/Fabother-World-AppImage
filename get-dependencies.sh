#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake \
    sdl12-compat

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Building Fabother World..."
echo "---------------------------------------------------------------"
REPO="https://github.com/fabiensanglard/Another-World-Bytecode-Interpreter"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./Another
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./Another
cmake ./ && make -j$(nproc)
mv -v raw ../AppDir/bin/fabother-world
