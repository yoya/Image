#! /bin/bash
set -euo pipefail

# require)
# - ImageMagick: https://imagemagick.org/
# - ExifTool:    https://exiftool.org/

export IM_CONVERT=convert  # ImageMagick 6 & legacy 7
#export IM_CONVERT=magick  # ImageMagick 7
export PYTHON=python
export EXIFTOOL=exiftool
# $EXIFTOOL の-delete-original が動かないので。
export ORIGINAL_SUFFIX="_original"

SAMPLE_RGBY="RGBY"

OUTPUT_DIR="output"
mkdir -p $OUTPUT_DIR

# Sample File
echo "Sample File"
sh ./sample.sh $SAMPLE_RGBY $OUTPUT_DIR

# ColorSpace Grayscale / RGB / CMYK
echo "ColorSpace"
sh ./colorspace.sh $SAMPLE_RGBY $OUTPUT_DIR "color"

# Palette - Bitdepth に含まれるので省略

# Bitdepth
echo "Bitdepth"
sh ./bitdepth.sh $SAMPLE_RGBY $OUTPUT_DIR "bitdepth"

# Alpha plane
echo "Alpha plane"
sh ./alpha.sh $SAMPLE_RGBY $OUTPUT_DIR "alpha"

# Chroma subsampling
echo "Chroma subsampling"
sh ./chromasub.sh $SAMPLE_RGBY $OUTPUT_DIR "chromasub"

# ICC Profile
echo "ICC Profile"
sh ./iccprof.sh $SAMPLE_RGBY $OUTPUT_DIR "iccprof"

# Exif Orientation
echo "Exif Orientation"
sh ./orient.sh $SAMPLE_RGBY $OUTPUT_DIR "orient"

# DPI metadata
echo "DPI metadata"
sh ./dpi.sh $SAMPLE_RGBY $OUTPUT_DIR "dpi"

# GPS Info
echo "GPS Info"
sh ./gps.sh $SAMPLE_RGBY $OUTPUT_DIR "gps"

# Thumbnail
echo "Thumbnail"
sh ./thumb.sh $SAMPLE_RGBY $OUTPUT_DIR "thumb"

# Interlace / Progressive
echo "Interlace / Progressive"
sh ./interlace.sh $SAMPLE_RGBY $OUTPUT_DIR "interlace"

# Size of Spacial(width/height) & Filevolume
echo "Size Limit Spacial(width/height) & Filesize"
sh ./size.sh $SAMPLE_RGBY $OUTPUT_DIR "size"
