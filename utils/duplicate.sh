#!/bin/bash
export ROOT_PATH="./gawk"
export BIN_PATH=$ROOT_PATH/gawk
export PARSE_FILE_PATH=$ROOT_PATH/list.log
export CANDIDATE_DIR=$ROOT_PATH/manual_testcases

if [ ! -d "bt_result" ]; then
  mkdir bt_result
else
  echo "bt_result dir already exist..."
fi

for file in $CANDIDATE_DIR/*; do
    filename=$(basename $file)
    gdb -batch -x ./utils/duplicate.gdb --args $BIN_PATH -f $file $PARSE_FILE_PATH > bt_result/$filename 2>&1 
    echo "Finish $filename"
done


# gdb -batch -x ./utils/duplicate.gdb --args $BIN_PATH -f ~/Downloads/POCFILE $PARSE_FILE_PATH > bt_result/POCFILE 2>&1 
# echo "Finish POC"