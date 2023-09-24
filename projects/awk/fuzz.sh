#!/bin/bash
# Fuzzer build config for AWK
################################################################################
SRC=/src
CC=afl-gcc-fast
FUZZDATE=$(date +"%m-%d")
PARALLEL=3

cd $SRC/awk
mkdir fuzz_"${FUZZDATE}"_output

# Parallel 
if [ $PARALLEL -gt 1 ];
then
    tmux new -s awkmaster -d
    COMMAND="afl-fuzz -m none -i fuzz_corpus -o fuzz_"${FUZZDATE}"_output -M Master -- ./awk -f @@ list.log"
    tmux send -t awkmaster "${COMMAND}" Enter
    for (( i = 1; i < $PARALLEL; i++))
    do
        tmux new -s awkslave"${i}" -d
        COMMAND="afl-fuzz -m none -i fuzz_corpus -o fuzz_"${FUZZDATE}"_output -S Slave"${i}" -- ./awk -f @@ list.log"
        tmux send -t awkslave"${i}" "${COMMAND}" Enter
    done
else
    afl-fuzz -m none -i fuzz_corpus -o fuzz_"${FUZZDATE}"_output -- ./awk -f @@ list.log
fi

# Whatsup
# afl-whatsup fuzz_"${FUZZDATE}"_output