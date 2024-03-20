#! /bin/bash
set -euo pipefail

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_DPI_DIR="$2/$3"
mkdir -p $OUTPUT_DPI_DIR

ORIGINAL_SUFFIX="_original" # exiftool の-delete-original が動かないので

FILE=$OUTPUT_DIR/$SAMPLE_RGBY

# ref) https://exiftool.org/TagNames/JFIF.html
# ref) https://exiftool.org/TagNames/PNG.html#PhysicalPixel

# JFIF only
FILE_DPI="$OUTPUT_DPI_DIR/$SAMPLE_RGBY-jfifdpi.jpg"
cp $FILE.jpg $FILE_DPI
exiftool -q  -jfif:ResolutionUnit=1 -n \
         -jfif:Xresolution=72 -jfif:Yresolution=72 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

# pHYs only

FILE_DPI="$OUTPUT_DPI_DIR/$SAMPLE_RGBY-physdpi.png"
cp $FILE.png $FILE_DPI
exiftool -q -PixelsPerUnitX=2834 -PixelsPerUnitY=2834 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

# Exif only
FILE_DPI="$OUTPUT_DPI_DIR/$SAMPLE_RGBY-exifdpi.jpg"
cp $FILE.jpg $FILE_DPI
exiftool -q  -ResolutionUnit=2 -n -Xresolution=200 -Yresolution=200 \
         -jfif:ResolutionUnit=0 -n -jfif:Xresolution=0 -jfif:Yresolution=0 \
         $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

FILE_DPI="$OUTPUT_DPI_DIR/$SAMPLE_RGBY-exifdpi.png"
cp $FILE.png $FILE_DPI
exiftool -q -ResolutionUnit=2 -n -Xresolution=200 -Yresolution=200 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

# JFIF & Exif

FILE_DPI="$OUTPUT_DPI_DIR/$SAMPLE_RGBY-jfifexifdpi.jpg"
cp $FILE.jpg $FILE_DPI
exiftool -q -jfif:ResolutionUnit=1 -n \
         -jfif:Xresolution=72 -jfif:Yresolution=72 \
         -ResolutionUnit=2 -n -Xresolution=200 -Yresolution=200 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

# pHYs & Exif

FILE_DPI="$OUTPUT_DPI_DIR/$SAMPLE_RGBY-physexifdpi.png"
cp $FILE.png $FILE_DPI
exiftool -q -ResolutionUnit=2 -n -Xresolution=200 -Yresolution=200 \
         -PixelsPerUnitX=2834 -PixelsPerUnitY=2834 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX
