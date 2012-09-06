#!/bin/sh
set -e
date 
echo running release.sh

# Perform all the steps necessary to process the MASC files.

echo "---------------------------------------------------------"
# Clean up from previous runs and create required directories.
./setup.sh


# Check if we are supposed to rebuild the applications.
if [ "$1" = "build" ] ; then
	echo "---------------------------------------------------------"
	./build-all.sh
fi

echo "---------------------------------------------------------"
# Process the existing XCES annotations.
./prep.sh

echo "---------------------------------------------------------"
# Convert and align the FrameNet files.
./framenet.sh

echo "---------------------------------------------------------"
# Removes leading and trailing whitespace in regions.
./trim.sh
./check-align.sh

echo "---------------------------------------------------------"
# Generates headers from the MASC-MASTER file.
./headers.sh

#echo "---------------------------------------------------------"
# Make sure headers have links to all annotations files
# and don't contain links to non-existent header files.
./update-headers.sh

echo "---------------------------------------------------------"
# Link MPQA, NE, NC, and VC annotations to the Penn tokens.
./link-tokens.sh #SBI

echo "---------------------------------------------------------"
# Extract tokens from the PTB and FrameNet files.
# Also links tokens to quarks.
./tokenize.sh #SBI

echo "---------------------------------------------------------"
# Run all annotation files through the GraphParser
./parse-all.sh #SBI

echo "---------------------------------------------------------"
# Check annotation alignment, that is whitespace at the
# start or end of an annotation. Makes sure the trim.sh
# script worked.
./check-align.sh #SBI

echo "---------------------------------------------------------"
# Convert the standoff annotation files in ./data/data to 
# the new GrAF format before validation with the new schemas.
# Also copies the headers, which are already in the new format
# to the release directory.
./convert.sh #SBI

## TODO Change this to copy files from MASC2.
#echo "---------------------------------------------------------"
# Convert the existing MASC1 files into the new format.
#./masc1.sh 

echo "---------------------------------------------------------"
# Perform a schema validation of all document headers and standoff
# annotation files.
./validate.sh data/working/release #SBI

echo "---------------------------------------------------------"
# Divide the files into written and spoken components.
./divide.sh #SBI

echo "---------------------------------------------------------"
# Copy MASC 1/2 file to the release directory
./masc2.sh

echo "---------------------------------------------------------"
# Ensure all document headers contains an f.seg entry
./fix-fid.sh

#echo "---------------------------------------------------------"
# Load all standoff annotations for all documents.
# 02Sep12 - Currently causes an out of memory exception.
#./load-all.sh

echo "---------------------------------------------------------"
# Perform sanity checks and write reports.
./reports.sh

#echo "---------------------------------------------------------"
# Copies over original annotations, header, etc. and
# packages everything.
./package.sh #SBI
