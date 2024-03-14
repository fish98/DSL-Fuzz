#!/bin/bash
# Script for triage AWK bugs
################################################################################

# go env -w GO111MODULE=auto

SRC=/src
WORK=$(pwd)
PROJECT=awk

# FUZZDATE=$(date +"%m-%d")
# FUZZRESDIR="fuzz_${FUZZDATE}_output"

# git clone git@github.com:bnagy/crashwalk.git $WORK/$FUZZRESDIR

git clone https://github.com/jfoote/exploitable.git $SRC/exploitable && cd $SRC/exploitable
python setup.py install

export CW_EXPLOITABLE=$SRC/exploitable/exploitable

# Install go 1.16
cd $SRC
mkdir gopath
wget https://go.dev/dl/go1.16.1.linux-amd64.tar.gz
tar -xzf go1.16.1.linux-amd64.tar.gz
export GOROOT="/src/go"
export GOPATH="/src/gopath"
export GOBIN=$GOROOT/bin
export PATH=$PATH:$GOBIN

# Install CrashWalk 
export CGO_ENABLED=0 # Avoid CGO Error
go get -u github.com/bnagy/crashwalk/cmd/...

# 
cwtriage -root . -afl | tee crash-$PROJECT.log

# 2. Analyze the hang result