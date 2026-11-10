#!/bin/bash
# Description:
# Author:
# Date: Created on 2025-09-01 11:59:41
# libXtst
# https://cgit.git.savannah.nongnu.org/cgit/ratpoison.git/commit/?id=a34577dd8662d2cb3f617e187f9f60288d71ccbd

set -e  # Exit on any error

# sudo xbps-install -S libX11-devel libXtst-devel libXinerama-devel fontconfig-devel freetype-devel libXft-devel

echo "Starting Ratpoison build..."

# Clone and build Ratpoison
echo "Cloning and building Ratpoison..."
rm -rf ~/ratpoison  # Clean up previous clone
git clone https://https.git.savannah.gnu.org/git/ratpoison.git/
cd ratpoison
./autogen.sh

./configure --prefix=/tmp/ratpoison-build \
  --x-includes=/usr/include/X11 --x-libraries=/usr/lib \
  CFLAGS="-I/usr/include -I/usr/include/freetype2" \
  LDFLAGS="-L/usr/lib"

# ./configure --prefix=/tmp/ratpoison-build \
#   CFLAGS="-I/usr/include -I/usr/include/freetype-devel -I/usr/include/libpng-devel -I/usr/include/libXtst-devel" \
#   LDFLAGS="-L/usr/lib"

make -j2 -C src
make -C src install
cd ..

# Verify the binary
# echo "Verifying Ratpoison binary..."
# ls -l /tmp/ratpoison-build/bin/ratpoison
# ldd /tmp/ratpoison-build/bin/ratpoison
# /tmp/ratpoison-build/bin/ratpoison --version || { echo "Ratpoison version check failed"; exit 1; }

# Move binary to output directory
# mkdir -p /tmp/artifacts
# mv /tmp/ratpoison-build/bin/ratpoison /tmp/artifacts/ratpoison

echo "Build complete.

# Binary is at /tmp/artifacts/ratpoison"
