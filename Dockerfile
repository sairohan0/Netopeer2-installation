FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    pkg-config \
    perl \
    autoconf \
    automake \
    libtool \
    python3 \
    g++ \
    gcc \
    cmake \
    gcc-arm-linux-gnueabihf \
    g++-arm-linux-gnueabihf \
    binutils-arm-linux-gnueabihf \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists/*


# Sysroot path
#ENV SYSROOT_BASE=/opt/sysroots/x86_64
#RUN mkdir -p $SYSROOT_BASE/lib $SYSROOT_BASE/include $SYSROOT_BASE/pkgconfig

WORKDIR /build

COPY . /build

# Default command: build everything
#CMD ["bash", "scripts/build_all.sh"]

