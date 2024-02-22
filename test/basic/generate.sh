#! /bin/bash
set -u

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

ORIGINAL_SUFFIX="_original" # exiftool の-delete-original が動かないので
SUFFIX=".png"

FILE=$OUTPUT_DIR/$SAMPLE_RGBY
PREFIX=`basename $SAMPLE_RGBY $SUFFIX`

for i in `seq 1 8` ;
do
  FILE_ORIENT="$OUTPUT_DIR/$PREFIX-$i$SUFFIX"
  echo $FILE_ORIENT
  cp $FILE $FILE_ORIENT
  exiftool -Orientation=$i -n $FILE_ORIENT
  rm $FILE_ORIENT$ORIGINAL_SUFFIX
  case $i in
    "2") mogrify             -flop $FILE_ORIENT ;;
    "3") mogrify -rotate 180       $FILE_ORIENT ;;
    "4") mogrify -rotate 180 -flop $FILE_ORIENT ;;
    "5") mogrify -rotate -90 -flip $FILE_ORIENT ;;
    "6") mogrify -rotate -90       $FILE_ORIENT ;;
    "7") mogrify -rotate  90 -flip $FILE_ORIENT ;;
    "8") mogrify -rotate  90       $FILE_ORIENT ;;
  esac
done

# DPI metadata

# GPS Info

# Interlace

# Spacial Size

# File Size
