#! /bin/bash
set -euo pipefail

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_INTERLACE_DIR="$2/$3"

mkdir -p $OUTPUT_INTERLACE_DIR

$IM_CONVERT $OUTPUT_DIR/$SAMPLE_RGBY.png -interlace JPEG \
            "$OUTPUT_INTERLACE_DIR/${SAMPLE_RGBY}-prog.jpg"
$IM_CONVERT $OUTPUT_DIR/$SAMPLE_RGBY.png -interlace PNG \
            "$OUTPUT_INTERLACE_DIR/${SAMPLE_RGBY}-inter.png"
