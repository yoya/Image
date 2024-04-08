#! /bin/bash
set -euo pipefail

# require)
# - ImageMagick: https://imagemagick.org/
# - Python: https://www.python.org/
# - ExifTool:    https://exiftool.org/

export IM_CONVERT=convert  # ImageMagick 6 & legacy 7
#export IM_CONVERT=magick  # ImageMagick 7
export PYTHON=python
export EXIFTOOL=exiftool
# $EXIFTOOL の-delete-original が動かないので。
export ORIGINAL_SUFFIX="_original"

export TEST_SAMPLE_RGBY="RGBY"
export TEST_SAMPLE_Format="Format"

export TEST_OUTPUT_DIR="output"

mkdir -p $TEST_OUTPUT_DIR

# Sample File
echo "Sample File"
sh ./sample.sh

# ColorSpace Grayscale / RGB / CMYK
echo "ColorSpace"
sh ./colorspace.sh "color"

# Palette - Bitdepth に含まれるので省略

# Bitdepth
echo "Bitdepth"
sh ./bitdepth.sh "bitdepth"

# Alpha plane
echo "Alpha plane"
sh ./alpha.sh "alpha"

# Chroma subsampling
echo "Chroma subsampling"
sh ./chromasub.sh "chromasub"

# ICC Profile
echo "ICC Profile"
sh ./iccprof.sh "iccprof"

# Exif Orientation
echo "Exif Orientation"
sh ./orient.sh "orient"

# DPI metadata
echo "DPI metadata"
sh ./dpi.sh "dpi"

# GPS Info
echo "GPS Info"
sh ./gps.sh "gps"

# Thumbnail
echo "Thumbnail"
sh ./thumb.sh "thumb"

# Interlace / Progressive
echo "Interlace / Progressive"
sh ./interlace.sh "interlace"

# Size of Spacial(width/height) & Filevolume
echo "Size Limit Spacial(width/height) & Filesize"
sh ./size.sh "size"
