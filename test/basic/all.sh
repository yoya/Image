#! /bin/bash
set -euo pipefail

# require)
# - ImageMagick: https://imagemagick.org/
# - ExifTool:    https://exiftool.org/

OUTPUT_DIR="output"
mkdir -p $OUTPUT_DIR

IM_CONV=convert

# Sample File
echo "Sample File"

SAMPLE_RGBY="RGBY"

$IM_CONV -size 100x75 -font .New-York-Italic -pointsize 64 \
    -fill white -stroke black -strokewidth 1 -gravity center \
    \( \( xc:red  -annotate 0 R \) \( xc:green1 -annotate 0 G \) +append \) \
    \( \( xc:blue -annotate 0 B \) \( xc:yellow -annotate 0 Y \) +append \) \
    -append -depth 1 -strip $OUTPUT_DIR/$SAMPLE_RGBY.png
$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png $OUTPUT_DIR/$SAMPLE_RGBY.jpg

# ColorSpace Grayscale / RGB / CMYK
echo "ColorSpace"

OUTPUT_COLORSPACE_DIR="$OUTPUT_DIR/colospace"
sh ./colorspace.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_COLORSPACE_DIR

# Palette
echo "Palette"

OUTPUT_PALETTE_DIR="$OUTPUT_DIR/palette"
mkdir -p $OUTPUT_PALETTE_DIR

$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png -type palette "$OUTPUT_PALETTE_DIR/$SAMPLE_RGBY-palette.png"

# Bitdepth
echo "Bitdepth"

OUTPUT_BITDEPTH_DIR="$OUTPUT_DIR/bitdepth"
sh ./bitdepth.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_BITDEPTH_DIR

# Alpha plane
echo "Alpha plane"



# Chroma subsampling
echo "Chroma subsampling"

OUTPUT_CHROMASUB_DIR="$OUTPUT_DIR/chromasub"
sh ./chromasub.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_CHROMASUB_DIR

# ICC Profile
echo "ICC Profile"

OUTPUT_ICCPROF_DIR="$OUTPUT_DIR/iccprof"
sh ./iccprof.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_ICCPROF_DIR

# Exif Orientation
echo "Exif Orientation"

OUTPUT_ORIENT_DIR="$OUTPUT_DIR/orient"
sh ./orient.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_ORIENT_DIR

# DPI metadata
echo "DPI metadata"

# GPS Info
echo "GPS Info"

# Thumbnail
echo "Thumbnail"

# Interlace / Progressive
echo "Interlace / Progressive"

OUTPUT_INTERLACE_DIR="$OUTPUT_DIR/interlace"
sh ./interlace.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_INTERLACE_DIR

# Spacial Size
echo "Spacial Size"

# File Size
echo "File Size"
