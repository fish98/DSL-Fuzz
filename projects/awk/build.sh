#!/bin/bash
# Fuzzer build config for AWK
################################################################################

### PREQUISITE ### 
ls -la > list.log
# Modify Makefile
# Find gcc and then change to afl-clang-fast

### SANITIZER ###

# AFL_HARDEN=1 

CC=afl-clang-fast AFL_USE_ASAN=1 make

# ./configure CC=gcc CXX=g++ CFLAGS="-g -fsanitize=address"

mv a.out awk

### DIRECTORY ###

# Find some yaml or other input limitation with starters

### FUZZ ###

# Better note date in the output dir
FUZZDATE=$(date +"%m-%d")
mkdir fuzz_corpus && mkdir fuzz_"${FUZZDATE}"_output

# TODO: modify the relative path 
# cp -r seeds/* fuzz_corpus/*

# TMUX
afl-fuzz -m none -i fuzz_corpus -o fuzz_0407_output -M Master -- ./awk -f @@
afl-fuzz -m none -i fuzz_corpus -o fuzz_0407_output -S Slave1 -- ./awk -f @@