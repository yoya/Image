#! /bin/bash
set -euo pipefail

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_THUMB_DIR="$2/$3"

mkdir -p $OUTPUT_THUMB_DIR

FILE=$OUTPUT_DIR/$SAMPLE_RGBY

FILE_THUMB="$OUTPUT_THUMB_DIR/$SAMPLE_RGBY-exifthumb.jpg"
cp $FILE.jpg $FILE_THUMB
$EXIFTOOL -q "-ThumbnailImage<=${FILE}.jpg" $FILE_THUMB
rm $FILE_THUMB$ORIGINAL_SUFFIX

$PYTHON ../../python/jfif_thumb.py -i ${FILE}.jpg ${FILE}.jpg > \
        "$OUTPUT_THUMB_DIR/${SAMPLE_RGBY}-jfifthumb.jpg"
