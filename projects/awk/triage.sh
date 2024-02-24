#!/bin/bash
# Script for triage AWK bugs
################################################################################

# go env -w GO111MODULE=auto

SRC=/src
WORK=$(pwd)
PROJECT=awk

FUZZDATE=$(date +"%m-%d")
FUZZRESDIR="fuzz_${FUZZDATE}_output"

# git clone git@github.com:bnagy/crashwalk.git $WORK/$FUZZRESDIR

git clone git@github.com:jfoote/exploitable.git $SRC/exploitable && cd $SRC/exploitable
python setup.py install

export CW_EXPLOITABLE=$SRC/exploitable/exploitable

# git clone git@github.com:bnagy/crashwalk.git $SRC/crashwalk && cd $SRC/crashwalk
go get -u github.com/bnagy/crashwalk/cmd/...

# 1. Unpack the result

# 2. crashwalk

# 3. Analyze the hang result

# 4. 

mkdir "${PROJECT}"_"${FUZZDATE}"_output

docker run -i -t --privileged --net=host -v "$(pwd)"/fuzz_"${FUZZDATE}"_output:/out --name dslfuzz dsltest:1.0 /bin/bash


# For single input with GDB
### Build with -g and -O0

set args -f testcases/testcase1