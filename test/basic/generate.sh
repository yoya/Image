#! /bin/bash
set -euo pipefail

# require)
# - ImageMagick: https://imagemagick.org/
# - ExifTool:    https://exiftool.org/

OUTPUT_DIR="output"
mkdir -p $OUTPUT_DIR

# Sample File

SAMPLE_RGBY="RGBY.png"

convert -size 100x75 -font .New-York-Italic -pointsize 64 \
     -fill white -stroke black -strokewidth 1 -gravity center \
     \( \( xc:red  -annotate 0 R \) \( xc:green1 -annotate 0 G \) +append \) \
     \( \( xc:blue -annotate 0 B \) \( xc:yellow -annotate 0 Y \) +append \) \
     -append -depth 1 -strip $OUTPUT_DIR/$SAMPLE_RGBY

# Grayscale/Color

# Palette

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
