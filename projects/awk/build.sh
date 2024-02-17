#!/bin/bash
# Fuzzer build config for AWK
# docker run -i -t --privileged --net=host --name dsl-fuzz dsl:0.1 /bin/bash
################################################################################
export SRC=/src
export CC=afl-clang-fast

# TODO: fix afl-clang-fast build error

# System requirement
echo core >/proc/sys/kernel/core_pattern

cd /sys/devices/system/cpu
echo performance | tee cpu*/cpufreq/scaling_governor

# Clone repo
cd $SRC
git clone https://github.com/onetrueawk/awk.git $SRC/awk && cd $SRC/awk

### PREQUISITE ### 

# Modify Makefile
# Find gcc and then change to afl-clang-fast
sed -i "s/cc/${CC}/g" makefile

### SANITIZER ###

# AFL_HARDEN=1 

AFL_USE_ASAN=1 make

# ./configure CC=gcc CXX=g++ CFLAGS="-g -fsanitize=address"

mv a.out awk

### DIRECTORY ###

# Find some yaml or other input limitation with starters
# Dictionary etc.

### FUZZ ###

# Better note date in the output dir
mkdir fuzz_corpus

# TODO: modify the relative path 
cp -r $SRC/DSLFuzz/projects/awk/seeds/* fuzz_corpus/
cp -r $SRC/DSLFuzz/projects/awk/fuzz.sh .

# Prepare object file
ls -la > list.log

# Fuzz
# bash fuzz.sh

## If without tmux
apt update && apt install -y tmux