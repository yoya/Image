#! /bin/bash
set -euo pipefail

IM_CONV=convert

SAMPLE_RGBY=$1
OUTPUT_DIR=$2
OUTPUT_ICCPROF_DIR=$3
mkdir -p $OUTPUT_ICCPROF_DIR

INPUT_ICCPROF_DIR="../../icc"
ICC_sRGB="${INPUT_ICCPROF_DIR}/rgb/sRGB_LittleCMS1.icc"
ICC_GBR="${INPUT_ICCPROF_DIR}/rgb/GBR.icc"
ICC_JC2011C="${INPUT_ICCPROF_DIR}/cmyk/JapanColor2011Coated.icc"

# sRGB

OUTPUT_sRGB="${OUTPUT_ICCPROF_DIR}/${SAMPLE_RGBY}-sRGB"

$IM_CONV "${OUTPUT_DIR}/${SAMPLE_RGBY}.png" -profile ${ICC_sRGB} "${OUTPUT_sRGB}.jpg"
$IM_CONV "${OUTPUT_DIR}/${SAMPLE_RGBY}.png" -profile ${ICC_sRGB} "${OUTPUT_sRGB}.png"


# GBR
$IM_CONV "${OUTPUT_ICCPROF_DIR}/${SAMPLE_RGBY}-sRGB.png" -profile ${ICC_GBR} "${OUTPUT_ICCPROF_DIR}/${SAMPLE_RGBY}-GBR.jpg"
$IM_CONV "${OUTPUT_ICCPROF_DIR}/${SAMPLE_RGBY}-sRGB.png" -profile ${ICC_GBR} "${OUTPUT_ICCPROF_DIR}/${SAMPLE_RGBY}-GBR.png"

# CMYK

$IM_CONV "${OUTPUT_sRGB}.png" -profile ${ICC_JC2011C} "${OUTPUT_ICCPROF_DIR}/${SAMPLE_RGBY}-cmyk.jpg"
