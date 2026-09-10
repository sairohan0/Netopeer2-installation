# Netopeer2-installation

Cross-compiles [netopeer2](https://github.com/CESNET/netopeer2) and its full dependency
stack for **x86_64**, **ARM32 (armhf)**, and **ARM64 (aarch64)** inside Docker, and
produces a ready-to-use sysroot for each architecture.

## What gets built

For each target architecture the build compiles, in order, and installs everything into
a shared per-arch sysroot:

1. zlib
2. openssl
3. libssh
4. libpsl
5. libxcrypt
6. pcre
7. curl
8. libyang
9. sysrepo
10. libnetconf2
11. netopeer2
12. cJSON
13. rabbitmq-c

Later libraries in the list are linked against the ones built before them (e.g.
`libssh`/`curl` against `openssl` and `zlib`; `libyang`/`sysrepo`/`libnetconf2`/`netopeer2`
against all of the above), so they must be built in this order — which is exactly what
[`scripts/build_all.sh`](scripts/build_all.sh) does.

## Repository layout

```
.
├── build.sh                          # entry point — run this
├── docker-compose.yml                # builds the image and runs the build inside it
├── Dockerfile                        # Ubuntu 24.04 + cross toolchains for arm32/arm64
├── toolchain-x86.cmake               # CMake toolchain file used for the x86_64 build
├── toolchain-arm32.cmake             # CMake toolchain file for the armhf build
├── toolchain-arm64.cmake             # CMake toolchain file for the aarch64 build
└── scripts/
    ├── build_all.sh                  # runs all three per-arch installs in sequence
    └── install/
        ├── x86/install_x86.sh        # native x86_64 build
        ├── arm32/install_arm32.sh    # cross build for armhf (arm-linux-gnueabihf-*)
        └── arm64/install_arm64.sh    # cross build for aarch64 (aarch64-linux-gnu-*)
```

## Prerequisites

- Docker Engine with the Compose plugin (`docker compose ...`, not the standalone
  `docker-compose`).
- Enough free disk space for three full dependency builds (a few GB).
- `sudo`/write access to `/opt` on the host — the final step of `build.sh` copies the
  build output there.
- **Source trees for every dependency listed above**, placed in the repository root
  (the same directory as `build.sh`), using exactly these folder names:

  ```
  zlib/  openssl/  libssh/  libpsl/  libxcrypt/  pcre/  curl/
  libyang/  sysrepo/  libnetconf2/  netopeer2/  cJSON/  rabbitmq-c/
  ```

  These are **not** checked into this repository (only the build scripts and toolchain
  files are). `Dockerfile` does `COPY . /build`, so whatever sits next to `build.sh` at
  build time is what gets compiled — pull in the versions of each library your project
  is standardized on before running the build. The `scripts/install/*` scripts assume
  each folder is a normal, unbuilt source checkout (e.g. openssl/curl/libpsl/libxcrypt/pcre
  need their `./configure` script present; the CMake-based projects just need their
  top-level `CMakeLists.txt`).

You do **not** need to install the ARM cross-compilers yourself — `Dockerfile` installs
`gcc/g++/binutils` for both `arm-linux-gnueabihf` and `aarch64-linux-gnu` automatically
when the image is built.

## Running the build

From the repository root, with all dependency source folders in place:

```bash
./build.sh
```

This does the following:

1. Removes any existing `./sysroots` directory from a previous run.
2. Runs `docker compose up --build`, which:
   - Builds the `library_builder` image from `Dockerfile` (installs build tools and the
     ARM cross-toolchains, then copies the whole repo, including your dependency
     sources, into `/build` in the image).
   - Runs `scripts/build_all.sh` in a container, which builds x86_64 first, then arm32,
     then arm64, writing all output to `/opt/sysroots` inside the container. That path
     is volume-mounted to `./sysroots` on the host, so the result lands there as the
     build progresses.
3. Copies the finished `./sysroots` directory to `/opt/sysroots` on the host (needs
   permission to write to `/opt`, hence `sudo` may be required — run `sudo ./build.sh`
   if you get a permission error on this step).

A full run builds all three architectures back to back; expect it to take a while,
since ARM builds are cross-compiled from source with no caching between architectures.

### Rebuilding

Re-running `./build.sh` wipes `./sysroots` and rebuilds everything from scratch. On the
very first run, the `rm -r ./sysroots` step will print a harmless
"No such file or directory" error since there's nothing to remove yet — this does not
stop the build.

## Output layout

After a successful build, each architecture gets its own sysroot under
`/opt/sysroots/`:

```
/opt/sysroots/
├── x86_64/
│   ├── lib/            # all built .so/.a files, flattened together
│   ├── include/         # all headers, flattened together
│   ├── pkgconfig/       # all .pc files, flattened together
│   ├── zlib-x86/        # per-library install prefix (lib/, include/, ...)
│   ├── openssl-x86/
│   ├── libssh-x86/
│   ├── ...
│   └── netopeer2-x86/
├── arm32/                # same structure, "-arm32" suffixed prefixes
└── arm64/                # same structure, "-arm64" suffixed prefixes
```

The flattened `lib/`, `include/`, and `pkgconfig/` directories at the top of each arch
folder are what the CMake toolchain files (`toolchain-x86.cmake`,
`toolchain-arm32.cmake`, `toolchain-arm64.cmake`) point downstream builds at via
`CMAKE_FIND_ROOT_PATH` and `PKG_CONFIG_PATH` — use those toolchain files if you need to
build additional software (e.g. an application linking against netopeer2) against one
of these sysroots outside of this repo.

## Notes

- The toolchain files hardcode `/opt/sysroots/<arch>/...` paths, so the sysroots must
  end up at that exact location on the host for downstream builds to find them — this
  is why `build.sh` copies `./sysroots` to `/opt/sysroots` after the container finishes.
- `docker-compose.yml` builds a single service (`alpha`) that runs the entire
  three-architecture build sequentially; there's currently no way to build just one
  architecture without editing `scripts/build_all.sh`.
