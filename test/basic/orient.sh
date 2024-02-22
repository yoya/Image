#! /bin/bash
set -euo pipefail


SAMPLE_RGBY=$1
OUTPUT_DIR=$2
OUTPUT_ORIENT_DIR=$3

mkdir -p $OUTPUT_ORIENT_DIR

ORIGINAL_SUFFIX="_original" # exiftool の-delete-original が動かないので
SUFFIX=".png"

FILE=$OUTPUT_DIR/$SAMPLE_RGBY
PREFIX=`basename $SAMPLE_RGBY $SUFFIX`

for i in `seq 1 8` ;
do
  FILE_ORIENT="$OUTPUT_ORIENT_DIR/$PREFIX-$i$SUFFIX"
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
