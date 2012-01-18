#!/bin/bash

# Converts the GrAF standoff annotation files to the latest version
source ./config.sh

echo Converting standoff files to latest GrAF version.
cp -f $OUT/*.hdr $WORK/release
cp -f $OUT/*.txt $WORK/release
groovy scripts/convert.groovy $OUT $WORK/release
