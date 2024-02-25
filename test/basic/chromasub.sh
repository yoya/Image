#! /bin/bash
set -euo pipefail

IM_CONV=convert

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_CHROMASUB_DIR=$3
mkdir -p $OUTPUT_CHROMASUB_DIR

for s in 4:2:0 4:2:2 4:4:4 ;
  do
    $IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png -sampling-factor $s \
             "$OUTPUT_CHROMASUB_DIR/${SAMPLE_RGBY}-${s}.jpg"
done
