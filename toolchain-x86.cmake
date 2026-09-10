# Target system
#set(CMAKE_SYSTEM_NAME Linux)
#set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_C_COMPILER /usr/bin/gcc)
set(CMAKE_CXX_COMPILER /usr/bin/g++)

set(ENV{PKG_CONFIG_PATH} "/opt/sysroots/x86_64/pkgconfig:$ENV{PKG_CONFIG_PATH}")
# Root paths for includes and libraries
set(CMAKE_FIND_ROOT_PATH
    /opt/sysroots/x86_64/curl-x86
    /opt/sysroots/x86_64/zlib-x86
    /opt/sysroots/x86_64/libyang-x86
    /opt/sysroots/x86_64/libpsl-x86
    /opt/sysroots/x86_64/pcre-x86
    /opt/sysroots/x86_64/openssl-x86
    /opt/sysroots/x86_64/libxcrypt-x86
    /opt/sysroots/x86_64/libssh-x86
    /opt/sysroots/x86_64/libnetconf2-x86
    /opt/sysroots/x86_64/sysrepo-x86
)

# Include directories
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} \
-I/opt/sysroots/x86_64/curl-x86/include \
-I/opt/sysroots/x86_64/zlib-x86/include \
-I/opt/sysroots/x86_64/libyang-x86/include \
-I/opt/sysroots/x86_64/libpsl-x86/include \
-I/opt/sysroots/x86_64/pcre-x86/include \
-I/opt/sysroots/x86_64/openssl-x86/include \
-I/opt/sysroots/x86_64/libxcrypt-x86/include \
-I/opt/sysroots/x86_64/libssh-x86/include \
-I/opt/sysroots/x86_64/libnetconf2-x86/include \
-I/opt/sysroots/x86_64/sysrepo-x86/include")

set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} \
-L/opt/sysroots/x86_64/curl-x86/lib \
-L/opt/sysroots/x86_64/zlib-x86/lib \
-L/opt/sysroots/x86_64/libyang-x86/lib \
-L/opt/sysroots/x86_64/libpsl-x86/lib \
-L/opt/sysroots/x86_64/pcre2-x86/lib \
-L/opt/sysroots/x86_64/openssl-x86/lib64 \
-L/opt/sysroots/x86_64/libxcrypt-x86/lib \
-L/opt/sysroots/x86_64/libssh-x86/lib \
-L/opt/sysroots/x86_64/libnetconf2-x86/lib \
-L/opt/sysroots/x86_64/sysrepo-x86/lib")

# rpath-link is required to find shared dependencies at link time
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} \
-Wl,-rpath-link,/opt/sysroots/x86_64/curl-x86/lib \
-Wl,-rpath-link,/opt/sysroots/x86_64/zlib-x86/lib \
-Wl,-rpath-link,/opt/sysroots/x86_64/libyang-x86/lib \
-Wl,-rpath-link,/opt/sysroots/x86_64/libpsl-x86/lib \
-Wl,-rpath-link,/opt/sysroots/x86_64/pcre-x86/lib \
-Wl,-rpath-link,/opt/sysroots/x86_64/openssl-x86/lib64 \
-Wl,-rpath-link,/opt/sysroots/x86_64/libxcrypt-x86/lib \
-Wl,-rpath-link,/opt/sysroots/x86_64/libssh-x86/lib \
-Wl,-rpath-link,/opt/sysroots/x86_64/libnetconf2-x86/lib \
-Wl,-rpath-link,/opt/sysroots/x86_64/sysrepo-x86/lib")

set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -L/opt/sysroots/x86_64/libxcrypt-arm32/lib -Wl,-rpath-link,/opt/sysroots/x86_64/libxcrypt-arm32/lib \
-L/opt/sysroots/x86_64/curl-x86/lib -Wl,-rpath-link,/opt/sysroots/x86_64/curl-x86/lib \
-L/opt/sysroots/x86_64/zlib-x86/lib -Wl,-rpath-link,/opt/sysroots/x86_64/zlib-x86/lib \
-L/opt/sysroots/x86_64/libyang-x86/lib  -Wl,-rpath-link,/opt/sysroots/x86_64/libyang-x86/lib \
-L/opt/sysroots/x86_64/libpsl-x86/lib -Wl,-rpath-link,/opt/sysroots/x86_64/libpsl-x86/lib \
-L/opt/sysroots/x86_64/pcre-x86/lib -Wl,-rpath-link,/opt/sysroots/x86_64/pcre-x86/lib \
-L/opt/sysroots/x86_64/openssl-x86/lib64 -Wl,-rpath-link,/opt/sysroots/x86_64/openssl-x86/lib64 \
-L/opt/sysroots/x86_64/libssh-x86/lib  -Wl,-rpath-link,/opt/sysroots/x86_64/libssh-x86/lib \
-L/opt/sysroots/x86_64/libnetconf2-x86/lib -Wl,-rpath-link,/opt/sysroots/x86_64/libnetconf2-x86/lib \
-L/opt/sysroots/x86_64/sysrepo-x86/lib -Wl,-rpath-link,/opt/sysroots/x86_64/sysrepo-x86/lib")


# Control search behavior
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
