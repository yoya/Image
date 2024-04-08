#! /bin/bash
set -euo pipefail

OUTPUT_ICCPROF_DIR="$TEST_OUTPUT_DIR/$1"

mkdir -p $OUTPUT_ICCPROF_DIR

INPUT_ICCPROF_DIR="../../icc"
ICC_sRGB="${INPUT_ICCPROF_DIR}/rgb/sRGB_LittleCMS1.icc"
ICC_GBR="${INPUT_ICCPROF_DIR}/rgb/GBR.icc"
ICC_JC2011C="${INPUT_ICCPROF_DIR}/cmyk/JapanColor2011Coated.icc"

# sRGB

OUTPUT_sRGB="${OUTPUT_ICCPROF_DIR}/${TEST_SAMPLE_RGBY}-sRGB"

$IM_CONVERT "${TEST_OUTPUT_DIR}/${TEST_SAMPLE_RGBY}.png" -profile ${ICC_sRGB} "${OUTPUT_sRGB}.jpg"
$IM_CONVERT "${TEST_OUTPUT_DIR}/${TEST_SAMPLE_RGBY}.png" -profile ${ICC_sRGB} "${OUTPUT_sRGB}.png"

# GBR
$IM_CONVERT "${OUTPUT_ICCPROF_DIR}/${TEST_SAMPLE_RGBY}-sRGB.png" -profile ${ICC_GBR} "${OUTPUT_ICCPROF_DIR}/${TEST_SAMPLE_RGBY}-GBR.jpg"
$IM_CONVERT "${OUTPUT_ICCPROF_DIR}/${TEST_SAMPLE_RGBY}-sRGB.png" -profile ${ICC_GBR} "${OUTPUT_ICCPROF_DIR}/${TEST_SAMPLE_RGBY}-GBR.png"

# CMYK

$IM_CONVERT "${OUTPUT_sRGB}.png" -profile ${ICC_JC2011C} "${OUTPUT_ICCPROF_DIR}/${TEST_SAMPLE_RGBY}-cmyk.jpg"
