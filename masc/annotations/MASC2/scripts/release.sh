#!/bin/bash


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

#echo "---------------------------------------------------------"
# Process committed belief annotations.
# ./cb.sh #not yet present in MASC 2

#echo "---------------------------------------------------------"
# Process event annotations.
# ./event.sh #not yet present in MASC 2

echo "---------------------------------------------------------"
# Convert and align the MPQA files.
./mpqa.sh

echo "---------------------------------------------------------"
# Convert and align the Penn Tree Bank files.
./ptb.sh

echo "---------------------------------------------------------"
# Convert and align the FrameNet files.
./framenet.sh

#echo "---------------------------------------------------------"
# Process the "out of stream" corrections.
#./corrections.sh

echo "---------------------------------------------------------"
# Add missing IDs to sentence annotations.
./fix-ids.sh

echo "---------------------------------------------------------"
# Extract tokens from the PTB and FrameNet files.
# Also links tokens to quarks.
./tokenize.sh

echo "---------------------------------------------------------"
# Make sure headers have links to all annotations files
# and don't contain links to non-existent header files.
./update-headers.sh

echo "---------------------------------------------------------"
# Link the logical annotations into a tree.
echo "TODO: fix-logical.sh (make-tree.jar) needs fixing"
#./fix-logical.sh

echo "---------------------------------------------------------"
# Link NE, NC, and VC annotations to the PTB tokens.
./link-tokens.sh

#echo "---------------------------------------------------------"
# Copy over hand corrected files before validation starts.
#./hand-corrected.sh #not yet present in MASC 2

echo "---------------------------------------------------------"
# Run all annotation files through the GraphParser
./parse-all.sh

echo "---------------------------------------------------------"
# Check annotation alignment, that is whitespace at the
# start or end of an annotation.
./check-align.sh

echo "---------------------------------------------------------"
# Convert the standoff annotation files in ./data/data to 
# the new GrAF format before validation with the new schemas.
# TODO: The header files need to be copied as well.
./convert.sh

echo "---------------------------------------------------------"
# Perform a schema validation of all document headers and standoff
# annotation files.
./validate.sh

echo "---------------------------------------------------------"
echo TODO: The divide.sh and package.sh scripts needs to be updated.
# Divide the files into written and spoken components.
#./divide.sh

#echo "---------------------------------------------------------"
# Copies other original annotations, header, etc. and
# packages everything.
#./package.sh
