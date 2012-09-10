#!/bin/bash

# Converts the files from MASC 1 into the new GrAF format and puts them the
# the release folder. Also processes the recent fixes to MASC 1.
set -e
source ./config.sh

echo "running copy-masc1.sh"

MASC1=$CORPORA/MASC-1.0.4

cp $MASC1/written/*.* $WORK/release
cp $MASC1/spoken/*.* $WORK/release
