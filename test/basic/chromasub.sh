#! /bin/bash
set -euo pipefail

OUTPUT_CHROMASUB_DIR="$TEST_OUTPUT_DIR/$1"

mkdir -p $OUTPUT_CHROMASUB_DIR

for s in 4:2:0 4:2:2 4:4:4 ;
  do
    $IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png -sampling-factor $s \
                "$OUTPUT_CHROMASUB_DIR/${TEST_SAMPLE_RGBY}-${s}.jpg"
done
