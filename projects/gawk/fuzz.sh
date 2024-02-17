#!/bin/bash
# fuzzer execution for gawk
################################################################################
SRC=/src
FUZZDATE=$(date +"%m-%d")
PARALLEL=3

cd $SRC/gawk
mkdir fuzz_"${FUZZDATE}"_output

# Parallel 
if [ $PARALLEL -gt 1 ];
then
    tmux new -s gawkmaster -d
    COMMAND="afl-fuzz -m none -i fuzz_corpus -o fuzz_"${FUZZDATE}"_output -M Master -- ./gawk -f @@ list.log"
    tmux send -t gawkmaster "${COMMAND}" Enter
    for (( i = 1; i < $PARALLEL; i++))
    do
        tmux new -s gawkslave"${i}" -d
        COMMAND="afl-fuzz -m none -i fuzz_corpus -o fuzz_"${FUZZDATE}"_output -S Slave"${i}" -- ./gawk -f @@ list.log"
        tmux send -t gawkslave"${i}" "${COMMAND}" Enter
    done
else
    afl-fuzz -m none -i fuzz_corpus -o fuzz_"${FUZZDATE}"_output -- ./gawk -f @@ list.log
fi

# Whatsup
# afl-whatsup fuzz_"${FUZZDATE}"_output