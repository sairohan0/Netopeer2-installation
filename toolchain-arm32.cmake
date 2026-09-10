# Target system
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Cross compilers
set(CMAKE_C_COMPILER  arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)

set(ENV{PKG_CONFIG_PATH} "/opt/sysroots/arm32/pkgconfig:$ENV{PKG_CONFIG_PATH}")

# Root paths for includes and libraries
set(CMAKE_FIND_ROOT_PATH
    /usr/arm-linux-gnueabihf
    /opt/sysroots/arm32/curl-arm32
    /opt/sysroots/arm32/zlib-arm32
    /opt/sysroots/arm32/libyang-arm32
    /opt/sysroots/arm32/libpsl-arm32
    /opt/sysroots/arm32/pcre-arm32
    /opt/sysroots/arm32/openssl-arm32
    /opt/sysroots/arm32/libxcrypt-arm32
    /opt/sysroots/arm32/libssh-arm32
    /opt/sysroots/arm32/libnetconf2-arm32
    /opt/sysroots/arm32/sysrepo-arm32
)

# Include directories
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} \
-I/opt/sysroots/arm32/curl-arm32/include \
-I/opt/sysroots/arm32/zlib-arm32/include \
-I/opt/sysroots/arm32/libyang-arm32/include \
-I/opt/sysroots/arm32/libpsl-arm32/include \
-I/opt/sysroots/arm32/pcre-arm32/include \
-I/opt/sysroots/arm32/openssl-arm32/include \
-I/opt/sysroots/arm32/libxcrypt-arm32/include \
-I/opt/sysroots/arm32/libssh-arm32/include \
-I/opt/sysroots/arm32/libnetconf2-arm32/include \
-I/opt/sysroots/arm32/sysrepo-arm32/include")

set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} \
-L/opt/sysroots/arm32/curl-arm32/lib \
-L/opt/sysroots/arm32/zlib-arm32/lib \
-L/opt/sysroots/arm32/libyang-arm32/lib \
-L/opt/sysroots/arm32/libpsl-arm32/lib \
-L/opt/sysroots/arm32/pcre-arm32/lib \
-L/opt/sysroots/arm32/openssl-arm32/lib \
-L/opt/sysroots/arm32/libxcrypt-arm32/lib \
-L/opt/sysroots/arm32/libssh-arm32/lib \
-L/usr/arm-linux-gnueabihf/lib \
-L/opt/sysroots/arm32/libnetconf2-arm32/lib \
-L/opt/sysroots/arm32/sysrepo-arm32/lib")

# rpath-link is required to find shared dependencies at link time
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} \
-Wl,-rpath-link,/opt/sysroots/arm32/curl-arm32/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/zlib-arm32/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/libyang-arm32/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/libpsl-arm32/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/pcre-arm32/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/openssl-arm32/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/libxcrypt-arm32/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/libssh-arm32/lib \
-Wl,-rpath-link,/usr/arm-linux-gnueabihf/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/sysrepo-arm32/lib \
-Wl,-rpath-link,/opt/sysroots/arm32/libnetconf2-arm32/lib")

set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -L/opt/sysroots/arm32/libxcrypt-arm32/lib -Wl,-rpath-link,/opt/sysroots/arm32/libxcrypt-arm32/lib \
-L/opt/sysroots/arm32/curl-arm32/lib -Wl,-rpath-link,/opt/sysroots/arm32/curl-arm32/lib \
-L/opt/sysroots/arm32/zlib-arm32/lib -Wl,-rpath-link,/opt/sysroots/arm32/zlib-arm32/lib \
-L/opt/sysroots/arm32/libyang-arm32/lib  -Wl,-rpath-link,/opt/sysroots/arm32/libyang-arm32/lib \
-L/opt/sysroots/arm32/libpsl-arm32/lib -Wl,-rpath-link,/opt/sysroots/arm32/libpsl-arm32/lib \
-L/opt/sysroots/arm32/pcre-arm32/lib -Wl,-rpath-link,/opt/sysroots/arm32/pcre-arm32/lib \
-L/opt/sysroots/arm32/openssl-arm32/lib -Wl,-rpath-link,/opt/sysroots/arm32/openssl-arm32/lib \
-L/opt/sysroots/arm32/libssh-arm32/lib  -Wl,-rpath-link,/opt/sysroots/arm32/libssh-arm32/lib \
-L/usr/arm-linux-gnueabihf/lib -Wl,-rpath-link,/usr/arm-linux-gnueabihf/lib \
-L/opt/sysroots/arm32/libnetconf2-arm32/lib -Wl,-rpath-link,/opt/sysroots/arm32/libnetconf2-arm32/lib \
-L/opt/sysroots/arm32/sysrepo-arm32/lib -Wl,-rpath-link,/opt/sysroots/arm32/sysrepo-arm32/lib")


# Control search behavior
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

