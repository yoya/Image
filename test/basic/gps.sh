#! /bin/bash
set -euo pipefail

OUTPUT_GPS_DIR="$TEST_OUTPUT_DIR/$1"

mkdir -p $OUTPUT_GPS_DIR

FILE=$TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY

for s in png jpg ; do
    # GPS Null Island N,E
    FILE_GPS="$OUTPUT_GPS_DIR/$TEST_SAMPLE_RGBY-gps-nullNE.$s"
    cp $FILE.$s $FILE_GPS
    $EXIFTOOL -q -gpslatituderef=N  -gpslatitude="0 0 0.00" \
              -gpslongituderef=E -gpslongitude="0 0 0.00" \
              $FILE_GPS
    rm $FILE_GPS$ORIGINAL_SUFFIX
    # GPS Null Island SW
    FILE_GPS="$OUTPUT_GPS_DIR/$TEST_SAMPLE_RGBY-gps-nullSW.$s"
    cp $FILE.$s $FILE_GPS
    $EXIFTOOL -q -gpslatituderef=S  -gpslatitude="0 0 0.00" \
              -gpslongituderef=W -gpslongitude="0 0 0.00" \
              $FILE_GPS
    rm $FILE_GPS$ORIGINAL_SUFFIX
    # GPS sample max value
    FILE_GPS="$OUTPUT_GPS_DIR/$TEST_SAMPLE_RGBY-gps-maxNE.$s"
    cp $FILE.$s $FILE_GPS
    $EXIFTOOL -q -gpslatituderef=N  -gpslatitude="179 59 59.99" \
              -gpslongituderef=E -gpslongitude="179 59 59.99" \
              $FILE_GPS
    rm $FILE_GPS$ORIGINAL_SUFFIX
    # GPS sample middle value
    FILE_GPS="$OUTPUT_GPS_DIR/$TEST_SAMPLE_RGBY-gps-middleSW.$s"
    cp $FILE.$s $FILE_GPS
    $EXIFTOOL -q -gpslatituderef=S  -gpslatitude="90 30 30" \
              -gpslongituderef=W -gpslongitude="90 30 30" \
              $FILE_GPS
    rm $FILE_GPS$ORIGINAL_SUFFIX
done
