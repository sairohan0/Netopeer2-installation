#!/bin/bash

SYSROOT_BASE=/opt/sysroots/arm32

PRESENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BASE_DIR="$(cd "$PRESENT_DIR/../../.." && pwd)"

echo "$BASE_DIR"

cd "$BASE_DIR/zlib"
make clean
CC=arm-linux-gnueabihf-gcc AR=arm-linux-gnueabihf-ar RANLIB=arm-linux-gnueabihf-ranlib ./configure --prefix="$SYSROOT_BASE/zlib-arm32"
make
make install
rm -rf $BASE_DIR/zlib/build

cd "$BASE_DIR/openssl"
make clean
CC=arm-linux-gnueabihf-gcc  AR=arm-linux-gnueabihf-ar  RANLIB=arm-linux-gnueabihf-ranlib   ./Configure linux-armv4   --prefix="$SYSROOT_BASE/openssl-arm32"          --with-zlib-include="$SYSROOT_BASE/zlib-arm32/include"          --with-zlib-lib="$SYSROOT/zlib-arm32/lib" 
make -j$(nproc)
make install

mkdir -p $SYSROOT_BASE/openssl-arm32/lib64
cp -r $SYSROOT_BASE/openssl-arm32/lib/* $SYSROOT_BASE/openssl-arm32/lib64/.

cd "$BASE_DIR/libssh"
rm -rf build
mkdir build && cd build
cmake .. -DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=arm -DCMAKE_C_COMPILER=arm-linux-gnueabihf-gcc -DCMAKE_CXX_COMPILER=arm-linux-gnueabihf-g++  -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libssh-arm32" -DZLIB_INCLUDE_DIR="$SYSROOT_BASE/zlib-arm32/include" -DZLIB_LIBRARY="$SYSROOT_BASE/zlib-arm32/lib/libz.so" -DOPENSSL_ROOT_DIR="$SYSROOT_BASE/openssl-arm32" -DOPENSSL_INCLUDE_DIR="$SYSROOT_BASE/openssl-arm32/include" -DOPENSSL_CRYPTO_LIBRARY="$SYSROOT_BASE/openssl-arm32/lib/libcrypto.so" -DOPENSSL_SSL_LIBRARY="$SYSROOT_BASE/openssl-arm32/lib/libssl.so" -DWITH_EXAMPLES=OFF -DWITH_TESTING=OFF
make
make install
rm -rf $BASE_DIR/libssh/build


cd "$BASE_DIR/libpsl"
make clean
CC=arm-linux-gnueabihf-gcc ./configure --prefix="$SYSROOT_BASE/libpsl-arm32" --host=arm-linux-gnueabihf  --disable-man     --disable-gtk-doc-html     --disable-gtk-doc 
make
make install

cd "$BASE_DIR/libxcrypt"
make clean
CC=arm-linux-gnueabihf-gcc ./configure --prefix="$SYSROOT_BASE/libxcrypt-arm32" --host=arm-linux-gnueabihf 
make -j$(nproc)
make install



cd "$BASE_DIR/pcre"
make clean
CC=arm-linux-gnueabihf-gcc ./configure --host=arm-linux-gnueabihf --prefix="$SYSROOT_BASE/pcre-arm32" 
make -j$(nproc)
make install

cd "$BASE_DIR/curl"
make clean
CC=arm-linux-gnueabihf-gcc ./configure  --host=arm-linux-gnueabihf  --prefix="$SYSROOT_BASE/curl-arm32"             --with-ssl="$SYSROOT_BASE/openssl-arm32"             --with-zlib="$SYSROOT_BASE/zlib-arm32" --with-libpsl="$SYSROOT_BASE/libpsl-arm32"
make -j$(nproc)
make install

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.


cp $SYSROOT_BASE/*/lib64/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/libyang"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libyang-arm32" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm32.cmake"
make
make install
rm -rf $BASE_DIR/libyang/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/sysrepo"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/sysrepo-arm32"   -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm32.cmake" -DPRINTED_CONTEXT_ADDRESS=0
make
make install
rm -rf $BASE_DIR/sysrepo/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/libnetconf2"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/libnetconf2-arm32" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm32.cmake"
make
make install
rm -rf $BASE_DIR/libnetconf2/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/netopeer2"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/netopeer2-arm32" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm32.cmake" -DSYSREPO_SETUP=OFF 
make
make install
rm -rf $BASE_DIR/netopeer2/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cd "$BASE_DIR/cJSON"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/cJSON-arm32" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm32.cmake"
make
make install
rm -rf $BASE_DIR/cJSON/build


cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.


cd "$BASE_DIR/rabbitmq-c"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$SYSROOT_BASE/rabbitmq-c-arm32" -DCMAKE_TOOLCHAIN_FILE="$BASE_DIR/toolchain-arm32.cmake"
make
make install
rm -rf $BASE_DIR/rabbitmq-c/build

cp $SYSROOT_BASE/*/lib/pkgconfig/* $SYSROOT_BASE/pkgconfig/.

cp $SYSROOT_BASE/*/lib/*so* $SYSROOT_BASE/lib/.

cp -r $SYSROOT_BASE/*/include/* $SYSROOT_BASE/include/.


