#!/bin/bash
# Fuzzer build config for GAWK
################################################################################
export SRC=/src
export CC=afl-clang-fast
export CXX=afl-clang-fast++

# System requirement
apt update
apt install -y tmux texinfo

echo core >/proc/sys/kernel/core_pattern

cd /sys/devices/system/cpu
echo performance | tee cpu*/cpufreq/scaling_governor

# Clone repo
cd $SRC
git clone https://git.savannah.gnu.org/git/gawk.git $SRC/gawk && cd $SRC/gawk

# Modify Makefile
# Find gcc and then change to afl-clang-fast

export AFL_HARDEN=1
export AFL_USE_ASAN=1

./configure CC=${CC} CXX=${CXX} CFLAGS="-g -fsanitize=address"

make

mkdir fuzz_corpus

# TODO: modify the relative path 
cp -r $SRC/DSLFuzz/projects/gawk/seeds/* fuzz_corpus/
cp -r $SRC/DSLFuzz/projects/gawk/fuzz.sh .

# Prepare object file
ls -la > list.log

# DIRECTORY

# FUZZ
	
# ./afl-fuzz -i afl_in -o afl_out -M Master -- ./program @@
# ./afl-fuzz -i afl_in -o afl_out -S Slave1 -- ./program @@