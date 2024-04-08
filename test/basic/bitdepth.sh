#! /bin/bash
set -euo pipefail

OUTPUT_BITDEPTH_DIR="$TEST_OUTPUT_DIR/$1"

mkdir -p $OUTPUT_BITDEPTH_DIR

FILL_COLOR=Green1

# Grayscale
for d in 1 2 4 8 16;
  do
    $IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png \
             -type Grayscale -depth $d \
             -define png:color-type=0 -define png:bit-depth=$d \
             "$OUTPUT_BITDEPTH_DIR/${TEST_SAMPLE_RGBY}-gray-depth${d}.png"
done

# TrueColor
for d in 8 16;
  do
    $IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png \
        -type Grayscale -depth $d -colorspace sRGB \
        -fill $FILL_COLOR -opaque White -background $FILL_COLOR \
        -define png:color-type=2 -define png:bit-depth=$d \
        "$OUTPUT_BITDEPTH_DIR/${TEST_SAMPLE_RGBY}-true-depth${d}.png"
done

# Palette
for d in 1 2 4 8 ;
  do
    $IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png \
        -type Grayscale -depth $d -colorspace sRGB \
        -fill $FILL_COLOR -opaque White -background $FILL_COLOR \
        -define png:color-type=3 -define png:bit-depth=$d \
        "$OUTPUT_BITDEPTH_DIR/${TEST_SAMPLE_RGBY}-palette-depth${d}.png"
done
