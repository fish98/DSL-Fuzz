# For AFL++ based image
FROM ubuntu:22.04

LABEL maintainer="jiongchiyu@gmail.com"
LABEL version="1.0"
LABEL description="Quick integrate fuzzing for DSL"

RUN mkdir /src 
ENV SRC /src

# Packages
RUN apt-get update && apt-get install -y git vim build-essential python3-dev automake cmake git flex \
bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev python3-pip apt-utils tmux

# For AFL++
RUN apt-get install -y lld-14 llvm-14 llvm-14-dev clang-14 || apt-get install -y lld llvm llvm-dev clang

RUN apt-get install -y gcc-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-plugin-dev libstdc++-$(gcc --version|head -n1|sed 's/\..*//'|sed 's/.* //')-dev

RUN apt-get install -y ninja-build

RUN git clone https://github.com/AFLplusplus/AFLplusplus $SRC/AFlplusplus && cd $SRC/AFlplusplus && make distrib && make install

# # System Config
RUN sysctl -w kernel.core_pattern="core-%e"

# Must start image with privileged parameter!!
# RUN echo core >/proc/sys/kernel/core_pattern

# 

RUN git clone https://github.com/fish98/DSL-Fuzz.git $SRC/dslfuzz