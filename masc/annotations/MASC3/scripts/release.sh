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
# Reads  : ./data/originals
# Writes : ./data/data
./prep.sh

echo "---------------------------------------------------------"
# Convert and align the FrameNet files.
# Reads  : ./data/originals/Framenet
# Staging: ./data/working/framenet 
# Writes : ./data/data
./framenet.sh

echo "---------------------------------------------------------"
# Removes leading and trailing whitespace in regions.
# Reads  : ./data/data
# Writes : ./data/data
./trim.sh

echo "---------------------------------------------------------"
# Generates headers from the MASC-MASTER file.
# Reads  : MASC_MASTER.csv file
# Staging: ./data/headers
# Writes : ./data/data
./headers.sh

echo "---------------------------------------------------------"
# Link MPQA, NE, NC, and VC annotations to the Penn tokens.
# Reads  : ./data/data
# Writes : ./data/data
./link-tokens.sh #SBI

echo "---------------------------------------------------------"
# Extract tokens from the PTB and FrameNet files.
# Also links tokens to quarks.
# Reads  : ./data/data
# Staging: ./data/working/tokens
# Writes : ./data/data
./tokenize.sh #SBI

echo "---------------------------------------------------------"
# Make sure headers have links to all annotations files
# and don't contain links to non-existent header files.
# Reads  : ./data/data
# Writes : ./data/data
./update-headers.sh

echo "---------------------------------------------------------"
# Run all annotation files through the GraphParser
# Reads  : ./data/data
# Writes : nothing
./parse-all.sh #SBI

echo "---------------------------------------------------------"
# Convert the standoff annotation files in ./data/data to 
# the new GrAF format before validation with the new schemas.
# Also copies the headers, which are already in the new format
# to the release directory.
# Reads  : ./data/data
# Writes : ./data/working/release
./convert.sh #SBI

echo "---------------------------------------------------------"
# Check annotation alignment, that is whitespace at the
# start or end of an annotation. Makes sure the trim.sh
# script worked.
# Reads  : ./data/working/release
# Writes : nothing
./check-align.sh #SBI

## TODO Change this to copy files from MASC2.
#echo "---------------------------------------------------------"
# Convert the existing MASC1 files into the new format.
#./masc1.sh 

### REMOVE ###
#exit

echo "---------------------------------------------------------"
# Fix any dependencies in the standoff annotation files that do
# not use the correct f.id value (some are missing the "f."
# prefix).
# Reads  : ./data/working/release
# Staging: ./data/working/staging
# Writes : ./data/working/release
./fix-dependencies.sh

echo "---------------------------------------------------------"
# Removes extraneous features from tokens.
# Reads  : ./data/working/release
# Staging: ./data/working/staging
# Writes : ./data/working/release
./fix-penn.sh

echo "---------------------------------------------------------"
# Divide the files into written and spoken components.
# Reads  : ./data/work/release
# Writes : ./data/release
./divide.sh #SBI

echo "---------------------------------------------------------"
# Copy MASC 2 files to the release directory
# Reads  : /var/corpora/MASC-2.0.0
# Writes : ./data/release
./masc2.sh

echo "---------------------------------------------------------"
# Ensure all document headers contains an f.seg entry and 
# all annotation file use correct f.id values.
# Reads  : ./data/release/data
# Writes : ./data/release/data
./fix-fid.sh

echo "---------------------------------------------------------"
# Last minute fixes.
# Reads  : ./data/release/data
# Writes : ./data/release/data
#./last-minute-fixes.sh

echo "---------------------------------------------------------"
# Adds a cesDoc element to the logical annotations if one doesn't exist.
# Reads  : ./data/release/data
# Writes : ./data/release/data
./fix-doc.sh

echo "---------------------------------------------------------"
# Ensures all feature values are represented with @value attributes.
# Reads  : ./data/release/data
# Writes : ./data/release/data
./fix-features.sh
exit

#echo "---------------------------------------------------------"
# Load all standoff annotations for all documents.
# 02Sep12 - Currently causes an out of memory exception.
#./load-all.sh

echo "---------------------------------------------------------"
# Perform a schema validation of all document headers and standoff
# annotation files.
# Reads  : ./data/release/data
# Writes : nothing
./validate.sh data/release/data #SBI

echo "---------------------------------------------------------"
# Perform sanity checks and write reports.
# Reads  :
# Writes :
./reports.sh

echo "---------------------------------------------------------"
# Create .tgz and .zip archives with the corpus.
# Reads  :
# Writes :
./package.sh #SBI
  
echo "---------------------------------------------------------"
# Copy corpus to local corpora directory and the archives
# to the ANC web server.
./deploy.sh