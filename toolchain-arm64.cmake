# Target system
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# Cross compilers
set(CMAKE_C_COMPILER  aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++)


set(ENV{PKG_CONFIG_PATH} "/opt/sysroots/arm64/pkgconfig:$ENV{PKG_CONFIG_PATH}")

# Root paths for includes and libraries
set(CMAKE_FIND_ROOT_PATH
    /opt/sysroots/arm64/curl-arm64
    /opt/sysroots/arm64/zlib-arm64
    /opt/sysroots/arm64/libyang-arm64
    /opt/sysroots/arm64/libpsl-arm64
    /opt/sysroots/arm64/pcre-arm64
    /opt/sysroots/arm64/openssl-arm64
    /opt/sysroots/arm64/libxcrypt-arm64
    /opt/sysroots/arm64/libssh-arm64
    /opt/sysroots/arm64/libnetconf2-arm64
    /opt/sysroots/arm64/sysrepo-arm64
)

# Include directories
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} \
-I/opt/sysroots/arm64/curl-arm64/include \
-I/opt/sysroots/arm64/zlib-arm64/include \
-I/opt/sysroots/arm64/libyang-arm64/include \
-I/opt/sysroots/arm64/libpsl-arm64/include \
-I/opt/sysroots/arm64/pcre-arm64/include \
-I/opt/sysroots/arm64/openssl-arm64/include \
-I/opt/sysroots/arm64/libxcrypt-arm64/include \
-I/opt/sysroots/arm64/libssh-arm64/include \
-I/opt/sysroots/arm64/libnetconf2-arm64/include \
-I/opt/sysroots/arm64/sysrepo-arm64/include")

set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} \
-L/opt/sysroots/arm64/curl-arm64/lib \
-L/opt/sysroots/arm64/zlib-arm64/lib \
-L/opt/sysroots/arm64/libyang-arm64/lib \
-L/opt/sysroots/arm64/libpsl-arm64/lib \
-L/opt/sysroots/arm64/pcre-arm64/lib \
-L/opt/sysroots/arm64/openssl-arm64/lib \
-L/opt/sysroots/arm64/libxcrypt-arm64/lib \
-L/opt/sysroots/arm64/libssh-arm64/lib \
-L/opt/sysroots/arm64/libnetconf2-arm64/lib \
-L/opt/sysroots/arm64/sysrepo-arm64/lib")

# rpath-link is required to find shared dependencies at link time
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} \
-Wl,-rpath-link,/opt/sysroots/arm64/curl-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/zlib-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/libyang-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/libpsl-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/pcre-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/openssl-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/libxcrypt-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/libssh-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/libnetconf2-arm64/lib \
-Wl,-rpath-link,/opt/sysroots/arm64/sysrepo-arm64/lib")

set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -L/opt/sysroots/arm64/libxcrypt-arm64/lib -Wl,-rpath-link,/opt/sysroots/arm64/libxcrypt-arm64/lib \
-L/opt/sysroots/arm64/curl-arm64/lib -Wl,-rpath-link,/opt/sysroots/arm64/curl-arm64/lib \
-L/opt/sysroots/arm64/zlib-arm64/lib -Wl,-rpath-link,/opt/sysroots/arm64/zlib-arm64/lib \
-L/opt/sysroots/arm64/libyang-arm64/lib  -Wl,-rpath-link,/opt/sysroots/arm64/libyang-arm64/lib \
-L/opt/sysroots/arm64/libpsl-arm64/lib -Wl,-rpath-link,/opt/sysroots/arm64/libpsl-arm64/lib \
-L/opt/sysroots/arm64/pcre-arm64/lib -Wl,-rpath-link,/opt/sysroots/arm64/pcre-arm64/lib \
-L/opt/sysroots/arm64/openssl-arm64/lib -Wl,-rpath-link,/opt/sysroots/arm64/openssl-arm64/lib \
-L/opt/sysroots/arm64/libssh-arm64/lib  -Wl,-rpath-link,/opt/sysroots/arm64/libssh-arm64/lib \
-L/opt/sysroots/arm64/libxcrypt-arm64/lib  -Wl,-rpath-link,/opt/sysroots/arm64/libxcrypt-arm64/lib \
-L/opt/sysroots/arm64/libnetconf2-arm64/lib -Wl,-rpath-link,/opt/sysroots/arm64/libnetconf2-arm64/lib \
-L/opt/sysroots/arm64/sysrepo-arm64/lib -Wl,-rpath-link,/opt/sysroots/arm64/sysrepo-arm64/lib")


# Control search behavior
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

