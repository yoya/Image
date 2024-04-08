#! /bin/bash
set -euo pipefail

OUTPUT_ALPHA_DIR="$TEST_OUTPUT_DIR/$1"

mkdir -p $OUTPUT_ALPHA_DIR

$IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png -transparent white \
            PNG32:"$OUTPUT_ALPHA_DIR/${TEST_SAMPLE_RGBY}-truealpha.png"

$IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png -transparent white \
            PNG8:"$OUTPUT_ALPHA_DIR/${TEST_SAMPLE_RGBY}-palettealpha.png"

$IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png -transparent white -type grayscale \
            "$OUTPUT_ALPHA_DIR/${TEST_SAMPLE_RGBY}-grayalpha.png"
