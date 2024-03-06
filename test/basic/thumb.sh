#! /bin/bash
set -euo pipefail

IM_CONV=convert

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_THUMB_DIR=$3
mkdir -p $OUTPUT_THUMB_DIR

ORIGINAL_SUFFIX="_original" # exiftool の-delete-original が動かないので

FILE=$OUTPUT_DIR/$SAMPLE_RGBY

cp $FILE.jpg "$OUTPUT_THUMB_DIR/${SAMPLE_RGBY}-exifthumb.jpg"
FILE_THUMB="$OUTPUT_THUMB_DIR/$SAMPLE_RGBY-exifthumb.jpg"
exiftool -q "-ThumbnailImage<=${FILE}.jpg" $FILE_THUMB
rm $FILE_THUMB$ORIGINAL_SUFFIX

python ../../python/jpegapp0_thumb.py -i ${FILE}.jpg ${FILE}.jpg > \
         "$OUTPUT_THUMB_DIR/${SAMPLE_RGBY}-app0thumb.jpg"
