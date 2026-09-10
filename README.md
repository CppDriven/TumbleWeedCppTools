

# TumbleWeed CPP Tools

This is a docker container based upon OpenSuse TumbleWeed, providing several important C++ development tools. While this OS has very recent tools, several are being manually in the docker image recipe, so we have full control even if the OS base image might be lagging behind.

## From the OS
- GCC
- Clang
- Make
- automake/autconf/libtool -> in order to build Valgrind

## Manually build
-  CMake
-  Ninja
-  CppCheck
-  Valgrind


# Quick Start

### Fetch the container

``` sh
docker pull ghcr.io/cppdriven/tumbleweedcpptools:latest
```

## Launch the container (and map in a host directory)

``` bash
docker run \
    --rm \
    --interactive \
    --tty \
    --mount type=bind,source=/path/on/host,target=/TheProject \
    ghcr.io/cppdriven/tumbleweedcpptools:latest
```

And in the container inside /TheProject you can find the mapped in directory, and you can start building your stuff in there.
