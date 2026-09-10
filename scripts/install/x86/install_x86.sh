#!/bin/bash

SYSROOT_BASE=/opt/sysroots/x86_64

PRESENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BASE_DIR="$(cd "$PRESENT_DIR/../../.." && pwd)"

echo "$BASE_DIR"

cd "$BASE_DIR/zlib"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/zlib-x86" 
make
make install
rm -rf $BASE_DIR/zlib/build

cp -r $SYSROOT_BASE/*/lib/* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.

cd "$BASE_DIR/openssl"
LDFLAGS="-Wl,-rpath,/opt/sysroots/x86_64/lib" ./config --prefix="$SYSROOT_BASE/openssl-x86"       --libdir=lib     --with-zlib-include="$SYSROOT_BASE/zlib-x86/include"          --with-zlib-lib="$SYSROOT_BASE/zlib-x86/lib"    --openssldir="$SYSROOT_BASE/openssl-x86/ssl" shared -Wl,-rpath,"$SYSROOT_BASE/openssl-x86/lib"  
make -j$(nproc)
make install

cp -r $SYSROOT_BASE/*/lib/* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.

cd "$BASE_DIR/libssh"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libssh-x86" -DZLIB_INCLUDE_DIR="$SYSROOT_BASE/zlib-x86/include" -DZLIB_LIBRARY="$SYSROOT_BASE/zlib-x86/lib/libz.so" -DOPENSSL_ROOT_DIR="$SYSROOT_BASE/openssl-x86" -DOPENSSL_INCLUDE_DIR="$SYSROOT_BASE/openssl-x86/include" -DOPENSSL_CRYPTO_LIBRARY="$SYSROOT_BASE/openssl-x86/lib/libcrypto.so" -DOPENSSL_SSL_LIBRARY="$SYSROOT_BASE/openssl-x86/lib/libssl.so"  -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath,/opt/sysroots/x86_64/lib" -DCMAKE_SHARED_LINKER_FLAGS="-L/opt/sysroots/x86_64/lib  -Wl,-rpath,/opt/sysroots/x86_64/lib"
make
make install
rm -rf $BASE_DIR/libssh/build

cp -r $SYSROOT_BASE/*/lib/* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.

cd "$BASE_DIR/libpsl"

LDFLAGS="-Wl,-rpath,/opt/sysroots/x86_64/lib" ./configure --prefix="$SYSROOT_BASE/libpsl-x86" 
make
make install

cp -r $SYSROOT_BASE/*/lib/* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.

cd "$BASE_DIR/libxcrypt"
LDFLAGS="-Wl,-rpath,/opt/sysroots/x86_64/lib" ./configure --prefix="$SYSROOT_BASE/libxcrypt-x86"
make -j$(nproc)
make install

cp -r $SYSROOT_BASE/*/lib/* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.

cd "$BASE_DIR/pcre"
LDFLAGS="-Wl,-rpath,/opt/sysroots/x86_64/lib" ./configure --prefix="$SYSROOT_BASE/pcre-x86" 
make -j$(nproc)
make install

cp -r $SYSROOT_BASE/*/lib/* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.

cd "$BASE_DIR/curl"
LDFLAGS="-Wl,-rpath,/opt/sysroots/x86_64/lib" ./configure --prefix="$SYSROOT_BASE/curl-x86"             --with-ssl="$SYSROOT_BASE/openssl-x86"             --with-zlib="$SYSROOT_BASE/zlib-x86" --with-libpsl="$SYSROOT_BASE/libpsl-x86"
make -j$(nproc)
make install

cp -r $SYSROOT_BASE/*/lib/* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.


cp $SYSROOT_BASE/*/lib64/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/libyang"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libyang-x86" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-x86.cmake"
make
make install
rm -rf $BASE_DIR/libyang/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/sysrepo"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/sysrepo-x86"   -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-x86.cmake"
make
make install
rm -rf $BASE_DIR/sysrepo/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/libnetconf2"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libnetconf2-x86" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-x86.cmake"
make
make install
rm -rf $BASE_DIR/libnetconf2/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/netopeer2"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/netopeer2-x86" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-x86.cmake" -DSYSREPO_SETUP=OFF 
make
make install
rm -rf $BASE_DIR/netopeer2/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/cJSON"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/cJSON-x86"
make
make install
rm -rf $BASE_DIR/cJSON/build


cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.


cd "$BASE_DIR/rabbitmq-c"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/rabbitmq-c-x86"  -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-x86.cmake"
make
make install
rm -rf $BASE_DIR/rabbitmq-c/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cp -r $SYSROOT_BASE/*/lib/* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.


