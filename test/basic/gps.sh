#! /bin/bash
set -euo pipefail

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ; OUTPUT_GPS_DIR=$3
mkdir -p $OUTPUT_GPS_DIR

ORIGINAL_SUFFIX="_original" # exiftool の-delete-original が動かないので

FILE=$OUTPUT_DIR/$SAMPLE_RGBY

# GPS Null Island N,E
for s in png jpg ; do
    FILE_GPS="$OUTPUT_GPS_DIR/$SAMPLE_RGBY-gps-nullNE.$s"
    cp $FILE.$s $FILE_GPS
    exiftool -q -gpslatitude="0 0 0.00" -gpslatituderef=N \
             -gpslongitude="0 0 0.00" -gpslongituderef=E \
             $FILE_GPS
    rm $FILE_GPS$ORIGINAL_SUFFIX
done
