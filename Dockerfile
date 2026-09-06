FROM opensuse/tumbleweed:latest

# Update and install packages using Zypper
RUN zypper --non-interactive refresh && \
    zypper --non-interactive install make gcc gcc-c++ git-core binutils libopenssl-3-devel && \
    zypper --non-interactive install clang libc++1 libc++-devel && \
    zypper --non-interactive install autoconf automake libtool && \
    zypper clean -a

RUN \
    git clone --branch v4.4.3 --depth=1 https://github.com/Kitware/CMake.git \
    && cd CMake \
    && ./bootstrap --parallel=$(nproc) && make -j $(nproc) && make install \
    && cd .. \
    && rm -rf CMake

RUN \
    git clone --branch v1.13.2 https://github.com/ninja-build/ninja.git \
    && cd ninja \
    && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -B build \
    && cmake --build build --parallel $(nproc) \
    && cmake --install build \
    && cd .. \
    && rm -rf ninja

RUN \
    git clone --branch 2.21.1 --depth=1 https://github.com/danmar/cppcheck.git \
    && cd cppcheck \
    && cmake -DCMAKE_BUILD_TYPE=RELEASE -DUSE_MATCHCOMPILER=On -B build \
    && cmake --build build --parallel $(nproc) \
    && cmake --install build \
    && cd .. \
    && rm -rf cppcheck

RUN \
    git clone --branch VALGRIND_3_27_1 --depth=1 https://sourceware.org/git/valgrind.git \
    && cd valgrind \
    && ./autogen.sh \
    && ./configure && make -j $(nproc) && make install \
    && cd .. \
    && rm -rf valgrind

CMD ["/bin/bash"]
