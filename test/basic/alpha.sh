#! /bin/bash
set -euo pipefail

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_ALPHA_DIR="$2/$3"

mkdir -p $OUTPUT_ALPHA_DIR

$IM_CONVERT $OUTPUT_DIR/$SAMPLE_RGBY.png -transparent white \
            PNG32:"$OUTPUT_ALPHA_DIR/${SAMPLE_RGBY}-truealpha.png"

$IM_CONVERT $OUTPUT_DIR/$SAMPLE_RGBY.png -transparent white \
            PNG8:"$OUTPUT_ALPHA_DIR/${SAMPLE_RGBY}-palettealpha.png"

$IM_CONVERT $OUTPUT_DIR/$SAMPLE_RGBY.png -transparent white -type grayscale \
            "$OUTPUT_ALPHA_DIR/${SAMPLE_RGBY}-grayalpha.png"
