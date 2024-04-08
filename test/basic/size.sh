#! /bin/bash
set -euo pipefail

OUTPUT_SIZE_DIR="$TEST_OUTPUT_DIR/$1"

mkdir -p $OUTPUT_SIZE_DIR

for s in png jpg ; do
    $IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png -sample "8x8!" \
                "$OUTPUT_SIZE_DIR/${TEST_SAMPLE_RGBY}-8x8.$s"
    $IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png -sample "640x480!" \
                "$OUTPUT_SIZE_DIR/${TEST_SAMPLE_RGBY}-640x480.$s"
    $IM_CONVERT -size 10000x10000 xc:black \
                "$OUTPUT_SIZE_DIR/${TEST_SAMPLE_RGBY}-black-10000x10000.$s"
    $IM_CONVERT -size 10000x10000 xc: +noise Random -quality 100 \
                "$OUTPUT_SIZE_DIR/${TEST_SAMPLE_RGBY}-random-10000x10000-q100.$s"
done
