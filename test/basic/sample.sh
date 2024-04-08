#! /bin/bash
set -euo pipefail

$IM_CONVERT -size 100x75 -font .New-York-Italic -pointsize 64 \
    -fill white -stroke black -strokewidth 1 -gravity center \
    \( \( xc:red  -annotate 0 R \) \( xc:green1 -annotate 0 G \) +append \) \
    \( \( xc:blue -annotate 0 B \) \( xc:yellow -annotate 0 Y \) +append \) \
    -append -depth 1 -strip $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png

$IM_CONVERT $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.png $TEST_OUTPUT_DIR/$TEST_SAMPLE_RGBY.jpg

for f in jpg png gif webp ;
do
    c=`echo $f | tr [a-z] [A-Z]`
    $IM_CONVERT -size 240x120 xc:Green -font Times-Bold -pointsize 64 \
                -fill white -stroke black -strokewidth 1 -gravity center \
                -annotate 0 "$c"  $TEST_OUTPUT_DIR/$TEST_SAMPLE_Format.$f
done
