#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q fabother-world-git | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DESKTOP=/usr/share/applications/fabother-world.desktop
export STARTUPWMCLASS=fabother-world
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/share/fabother-world/fabother-world

# Turn AppDir into AppImage
quick-sharun --make-appimage
