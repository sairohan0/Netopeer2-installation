#!/bin/bash

SYSROOT_BASE=/opt/sysroots/arm64

PRESENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BASE_DIR="$(cd "$PRESENT_DIR/../../.." && pwd)"

echo "$BASE_DIR"

cd "$BASE_DIR/zlib"
make clean
CC=aarch64-linux-gnu-gcc AR=aarch64-linux-gnu-ar  RANLIB=aarch64-linux-gnu-ranlib  ./configure --prefix="$SYSROOT_BASE/zlib-arm64"
make
make install
rm -rf $BASE_DIR/zlib/build

cd "$BASE_DIR/openssl"
make clean
CC=aarch64-linux-gnu-gcc AR=aarch64-linux-gnu-ar   RANLIB=aarch64-linux-gnu-ranlib   ./Configure linux-aarch64  --prefix="$SYSROOT_BASE/openssl-arm64"          --with-zlib-include="$SYSROOT_BASE/zlib-arm64/include"          --with-zlib-lib="$SYSROOT/zlib-arm64/lib" 
make -j$(nproc)
make install

#mkdir -p $SYSROOT_BASE/openssl-arm64/lib
#cp -r $SYSROOT_BASE/openssl-arm64/lib64/* $SYSROOT_BASE/openssl-arm64/lib/.

cd "$BASE_DIR/libssh"
rm -rf build
mkdir build && cd build
cmake .. -DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=aarch64 -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc   -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++  -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libssh-arm64" -DZLIB_INCLUDE_DIR="$SYSROOT_BASE/zlib-arm64/include" -DZLIB_LIBRARY="$SYSROOT_BASE/zlib-arm64/lib/libz.so" -DOPENSSL_ROOT_DIR="$SYSROOT_BASE/openssl-arm64" -DOPENSSL_INCLUDE_DIR="$SYSROOT_BASE/openssl-arm64/include" -DOPENSSL_CRYPTO_LIBRARY="$SYSROOT_BASE/openssl-arm64/lib/libcrypto.so" -DOPENSSL_SSL_LIBRARY="$SYSROOT_BASE/openssl-arm64/lib/libssl.so" -DWITH_EXAMPLES=OFF -DWITH_TESTING=OFF
make
make install
rm -rf $BASE_DIR/libssh/build


cd "$BASE_DIR/libpsl"
make clean
CC=aarch64-linux-gnu-gcc ./configure  --host=aarch64-linux-gnu --prefix="$SYSROOT_BASE/libpsl-arm64"   --disable-man     --disable-gtk-doc-html     --disable-gtk-doc 
make
make install

cd "$BASE_DIR/libxcrypt"
make clean
CC=aarch64-linux-gnu-gcc ./configure --prefix="$SYSROOT_BASE/libxcrypt-arm64"  --host=aarch64-linux-gnu
make -j$(nproc)
make install



cd "$BASE_DIR/pcre"
make clean
CC=aarch64-linux-gnu-gcc ./configure  --host=aarch64-linux-gnu --prefix="$SYSROOT_BASE/pcre-arm64" 
make -j$(nproc)
make install


cd "$BASE_DIR/curl"
make clean
CC=aarch64-linux-gnu-gcc ./configure  --host=aarch64-linux-gnu  --prefix="$SYSROOT_BASE/curl-arm64"             --with-ssl="$SYSROOT_BASE/openssl-arm64"             --with-zlib="$SYSROOT_BASE/zlib-arm64" --with-libpsl="$SYSROOT_BASE/libpsl-arm64"
make -j$(nproc)
make install

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.


cp $SYSROOT_BASE/*/lib64/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/libyang"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libyang-arm64" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm64.cmake"
make
make install
rm -rf $BASE_DIR/libyang/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/sysrepo"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/sysrepo-arm64"   -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm64.cmake" -DPRINTED_CONTEXT_ADDRESS=0
make
make install
rm -rf $BASE_DIR/sysrepo/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/libnetconf2"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libnetconf2-arm64" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm64.cmake"
make
make install
rm -rf $BASE_DIR/libnetconf2/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/netopeer2"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/netopeer2-arm64" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm64.cmake" -DSYSREPO_SETUP=OFF 
make
make install
rm -rf $BASE_DIR/netopeer2/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/cJSON"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/cJSON-arm64" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm64.cmake"
make
make install
rm -rf $BASE_DIR/cJSON/build


cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.


cd "$BASE_DIR/rabbitmq-c"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/rabbitmq-c-arm64" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm64.cmake"
make
make install
rm -rf $BASE_DIR/rabbitmq-c/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cp $SYSROOT_BASE/*/lib/*so* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.



