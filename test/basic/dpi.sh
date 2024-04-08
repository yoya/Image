#! /bin/bash
set -euo pipefail

OUTPUT_DPI_DIR="$TEST_OUTPUT_DIR/$1"

mkdir -p $OUTPUT_DPI_DIR

FILE=$TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY

# ref) https://$EXIFTOOL.org/TagNames/JFIF.html
# ref) https://$EXIFTOOL.org/TagNames/PNG.html#PhysicalPixel

# JFIF only
FILE_DPI="$OUTPUT_DPI_DIR/$TEST_SAMPLE_RGBY-jfifdpi.jpg"
cp $FILE.jpg $FILE_DPI
$EXIFTOOL -q  -jfif:ResolutionUnit=1 -n \
          -jfif:Xresolution=72 -jfif:Yresolution=72 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

# pHYs only

FILE_DPI="$OUTPUT_DPI_DIR/$TEST_SAMPLE_RGBY-physdpi.png"
cp $FILE.png $FILE_DPI
$EXIFTOOL -q -PixelsPerUnitX=2834 -PixelsPerUnitY=2834 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

# Exif only
FILE_DPI="$OUTPUT_DPI_DIR/$TEST_SAMPLE_RGBY-exifdpi.jpg"
cp $FILE.jpg $FILE_DPI
$EXIFTOOL -q  -ResolutionUnit=2 -n -Xresolution=200 -Yresolution=200 \
          -jfif:ResolutionUnit=0 -n -jfif:Xresolution=0 -jfif:Yresolution=0 \
          $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

FILE_DPI="$OUTPUT_DPI_DIR/$TEST_SAMPLE_RGBY-exifdpi.png"
cp $FILE.png $FILE_DPI
$EXIFTOOL -q -ResolutionUnit=2 -n -Xresolution=200 -Yresolution=200 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

# JFIF & Exif

FILE_DPI="$OUTPUT_DPI_DIR/$TEST_SAMPLE_RGBY-jfifexifdpi.jpg"
cp $FILE.jpg $FILE_DPI
$EXIFTOOL -q -jfif:ResolutionUnit=1 -n \
          -jfif:Xresolution=72 -jfif:Yresolution=72 \
          -ResolutionUnit=2 -n -Xresolution=200 -Yresolution=200 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX

# pHYs & Exif

FILE_DPI="$OUTPUT_DPI_DIR/$TEST_SAMPLE_RGBY-physexifdpi.png"
cp $FILE.png $FILE_DPI
$EXIFTOOL -q -ResolutionUnit=2 -n -Xresolution=200 -Yresolution=200 \
          -PixelsPerUnitX=2834 -PixelsPerUnitY=2834 $FILE_DPI
rm $FILE_DPI$ORIGINAL_SUFFIX
