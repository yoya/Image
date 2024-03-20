#! /bin/bash
set -euo pipefail

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_SIZE_DIR="$2/$3"

mkdir -p $OUTPUT_SIZE_DIR

for s in png jpg ; do
    $IM_CONVERT $OUTPUT_DIR/$SAMPLE_RGBY.png -sample "8x8!" \
                "$OUTPUT_SIZE_DIR/${SAMPLE_RGBY}-8x8.$s"
    $IM_CONVERT -size 10000x10000 xc:black \
                "$OUTPUT_SIZE_DIR/${SAMPLE_RGBY}-black-10000x10000.$s"
done
