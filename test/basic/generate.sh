#! /bin/bash
set -euo pipefail

# require)
# - ImageMagick: https://imagemagick.org/
# - ExifTool:    https://exiftool.org/

OUTPUT_DIR="output"
mkdir -p $OUTPUT_DIR

IM_CONV=convert

# Sample File

SAMPLE_RGBY="RGBY"

$IM_CONV -size 100x75 -font .New-York-Italic -pointsize 64 \
    -fill white -stroke black -strokewidth 1 -gravity center \
    \( \( xc:red  -annotate 0 R \) \( xc:green1 -annotate 0 G \) +append \) \
    \( \( xc:blue -annotate 0 B \) \( xc:yellow -annotate 0 Y \) +append \) \
    -append -depth 1 -strip $OUTPUT_DIR/$SAMPLE_RGBY.png
$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png $OUTPUT_DIR/$SAMPLE_RGBY.jpg

# ColorSpace Grayscale / RGB / CMYK

OUTPUT_COLORSPACE_DIR="$OUTPUT_DIR/colospace"
mkdir -p $OUTPUT_COLORSPACE_DIR

$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png -type grayscale "$OUTPUT_COLORSPACE_DIR/$SAMPLE_RGBY-gray.png"
$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png -type grayscale "$OUTPUT_COLORSPACE_DIR/$SAMPLE_RGBY-gray.jpg"

$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png "$OUTPUT_COLORSPACE_DIR/$SAMPLE_RGBY-rgb.png"
$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png "$OUTPUT_COLORSPACE_DIR/$SAMPLE_RGBY-rgb.jpg"

$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png -colorspace CMYK "$OUTPUT_COLORSPACE_DIR/$SAMPLE_RGBY-cmyk.jpg"

# Palette

OUTPUT_PALETTE_DIR="$OUTPUT_DIR/palette"
mkdir -p $OUTPUT_PALETTE_DIR

$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png -type palette "$OUTPUT_PALETTE_DIR/$SAMPLE_RGBY-palette.png"

# Bitdepth

# Alpha plane

# Chroma subsampling

# ICC Profile

# Exif Orientation

OUTPUT_ORIENT_DIR="$OUTPUT_DIR/orient"

sh ./orient.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_ORIENT_DIR

# DPI metadata

# GPS Info

# Interlace

# Spacial Size

# File Size
