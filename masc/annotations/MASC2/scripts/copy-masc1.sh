#!/bin/bash

# Converts the files from MASC 1 into the new GrAF format and puts them the
# the release folder. Also processes the recent fixes to MASC 1.
set -e
source ./config.sh

echo "Running $0"

MASC1=$CORPORA/MASC-1.0.4

cp $MASC1/data/written/*.* $WORK/release
cp $MASC1/data/spoken/*.* $WORK/release
