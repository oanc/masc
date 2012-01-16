#!/bin/bash

# Copies hand corrected files into the output directory.

echo running hand-corrected.sh

source ./config.sh

if [ -e $IN/hand-corrected ] ; then
	echo "Copying hand corrected files."
	cp $IN/hand-corrected/*.* $MASC
else
	echo "No hand corrected files found."
fi

