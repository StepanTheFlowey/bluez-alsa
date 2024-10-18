#!/bin/sh
set -e

export LDFLAGS="-flto -march=armv5tej -s -w"
export CFLAGS="$LDFLAGS -O3 -DNDEBUG"
export CPPFLAGS="$CFLAGS"
autoreconf --install
./configure
make -j`nproc`

mkdir OUTPUT
cp src/bluealsa utils/aplay/bluealsa-aplay src/asound/.libs/lib*.so OUTPUT
strip -s -R .comment -R .note* OUTPUT/*
cp src/asound/20-bluealsa.conf.in OUTPUT/20-bluealsa.conf
