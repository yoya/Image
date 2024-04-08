#! /bin/bash
set -euo pipefail

OUTPUT_THUMB_DIR="$TEST_OUTPUT_DIR/$1"

mkdir -p $OUTPUT_THUMB_DIR

FILE=$TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY

FILE_THUMB="$OUTPUT_THUMB_DIR/$TEST_SAMPLE_RGBY-exifthumb.jpg"
cp $FILE.jpg $FILE_THUMB
$EXIFTOOL -q "-ThumbnailImage<=${FILE}.jpg" $FILE_THUMB
rm $FILE_THUMB$ORIGINAL_SUFFIX

$PYTHON ../../python/jfif_thumb.py -i ${FILE}.jpg ${FILE}.jpg > \
        "$OUTPUT_THUMB_DIR/${TEST_SAMPLE_RGBY}-jfifthumb.jpg"
