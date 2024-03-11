#! /bin/bash
set -euo pipefail

IM_COMMAND=convert
SAMPLE=rose-vignette.png

VIGNETTE_VALUE=0  # hard vignette
# VIGNETTE_VALUE=32x32  # soft vignette

mkdir -p output ; cd output

$IM_COMMAND rose: -resize 240 \( +clone -fill white -colorize 100% \
    -background black -vignette $VIGNETTE_VALUE \) -alpha off \
    -compose copy_opacity -composite  $SAMPLE ;

echo "quality,jpeg,webp(RGBA),webp"

for q in `seq 10 10 90` ;
do 
    $IM_COMMAND rose-vignette.png -quality $q RGB-$q.jpg ;
    $IM_COMMAND rose-vignette.png -define webp:emulate-jpeg-size=1 \
                                  -quality $q RGBA-$q.webp ;
    $IM_COMMAND rose-vignette.png -define webp:emulate-jpeg-size=1 -alpha off \
                                  -quality $q RGB-$q.webp ;
    size_jpeg=`identify -format %b  RGB-$q.jpg |  sed "s/[^0-9]//g"`
    size_webpa=`identify -format %b  RGBA-$q.webp |  sed "s/[^0-9]//g"`
    size_webp=`identify -format %b  RGB-$q.webp |  sed "s/[^0-9]//g"`
    echo $q,$size_jpeg,$size_webpa,$size_webp
done
