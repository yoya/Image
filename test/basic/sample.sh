#! /bin/bash
set -euo pipefail

IM_CONV=convert

SAMPLE_RGBY=$1 ; OUTPUT_DIR=$2 ;

$IM_CONV -size 100x75 -font .New-York-Italic -pointsize 64 \
    -fill white -stroke black -strokewidth 1 -gravity center \
    \( \( xc:red  -annotate 0 R \) \( xc:green1 -annotate 0 G \) +append \) \
    \( \( xc:blue -annotate 0 B \) \( xc:yellow -annotate 0 Y \) +append \) \
    -append -depth 1 -strip $OUTPUT_DIR/$SAMPLE_RGBY.png
$IM_CONV $OUTPUT_DIR/$SAMPLE_RGBY.png $OUTPUT_DIR/$SAMPLE_RGBY.jpg
