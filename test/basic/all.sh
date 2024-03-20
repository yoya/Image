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
sh ./sample.sh $SAMPLE_RGBY $OUTPUT_DIR

# ColorSpace Grayscale / RGB / CMYK
echo "ColorSpace"

OUTPUT_COLORSPACE_DIR="$OUTPUT_DIR/colospace"
sh ./colorspace.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_COLORSPACE_DIR

# Palette - Bitdepth に含まれるので省略

# Bitdepth
echo "Bitdepth"

OUTPUT_BITDEPTH_DIR="$OUTPUT_DIR/bitdepth"
sh ./bitdepth.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_BITDEPTH_DIR

# Alpha plane
echo "Alpha plane"

OUTPUT_ALPHA_DIR="$OUTPUT_DIR/alpha"
sh ./alpha.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_ALPHA_DIR

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

OUTPUT_DPI_DIR="$OUTPUT_DIR/dpi"
sh ./dpi.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_DPI_DIR

# GPS Info
echo "GPS Info"

OUTPUT_GPS_DIR="$OUTPUT_DIR/gps"
sh ./gps.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_GPS_DIR

# Thumbnail
echo "Thumbnail"

OUTPUT_THUMB_DIR="$OUTPUT_DIR/thumb"
sh ./thumb.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_THUMB_DIR

# Interlace / Progressive
echo "Interlace / Progressive"

OUTPUT_INTERLACE_DIR="$OUTPUT_DIR/interlace"
sh ./interlace.sh $SAMPLE_RGBY $OUTPUT_DIR $OUTPUT_INTERLACE_DIR

# Spacial Size
echo "Spacial Size"

# File Size
echo "File Size"
