#!/bin/bash
# Fuzzer build config for GAWK
################################################################################

git clone https://git.savannah.gnu.org/git/gawk.git

# Modify Makefile
# Find gcc and then change to afl-clang-fast

# TMUX

# AFL_HARDEN=1 

# ./configure CC=gcc CXX=g++ CFLAGS="-g -fsanitize=address"

# DIRECTORY

# FUZZ
	
./afl-fuzz -i afl_in -o afl_out -M Master -- ./program @@
./afl-fuzz -i afl_in -o afl_out -S Slave1 -- ./program @@