#! /bin/bash
set -euo pipefail

IM_CONV=convert

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_THUMB_DIR=$3
mkdir -p $OUTPUT_THUMB_DIR

FILE=$OUTPUT_DIR/$SAMPLE_RGBY

cp $FILE.jpg "$OUTPUT_THUMB_DIR/${SAMPLE_RGBY}-exifthumb.jpg"
exiftool -q "-ThumbnailImage<=${FILE}.jpg" \
         "$OUTPUT_THUMB_DIR/${SAMPLE_RGBY}-exifthumb.jpg"

# TODO: APP0 thumbnail
