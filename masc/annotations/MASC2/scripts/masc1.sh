#!/bin/bash

# Converts the files from MASC 1 into the new GrAF format and puts them the
# the release folder. Also processes the recent fixes to MASC 1.
set -e
source ./config.sh

echo running masc1.sh

if [ -e $WORK/masc1 ] ; then
	rm -rf $WORK/masc1
fi
mkdir $WORK/masc1

echo Converting MASC One written.
groovy ./scripts/masc1.groovy $CORPORA/MASC-1.0.4/data $WORK/masc1
echo Moving files to staging directory
cp $WORK/masc1/written/*.* $WORK/release
cp $WORK/masc1/spoken/*.* $WORK/release

#echo Converting MASC One spoken.
#groovy ./scripts/masc1.groovy $CORPORA//MASC-1.0.4/data/spoken $WORK/release

#echo Converting MASC One fixes.
#groovy ./scripts/convert.groovy $DROPBOX/MASC2-3/MASC1-fixes $WORK/release
 