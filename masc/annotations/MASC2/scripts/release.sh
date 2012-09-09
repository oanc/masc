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
# Generate the header files.
./headers.sh

##echo "---------------------------------------------------------"
## Process committed belief annotations.
## ./cb.sh #not yet present in MASC 2

##echo "---------------------------------------------------------"
## Process event annotations.
## ./event.sh #not yet present in MASC 2

echo "---------------------------------------------------------"edit 
# Convert and align the MPQA files.
./mpqa.sh

echo "---------------------------------------------------------"
# Convert and align the Penn Tree Bank files.
./ptb.sh

echo "---------------------------------------------------------"
# Convert and align the FrameNet files.
./framenet.sh

#echo "---------------------------------------------------------"
# Make sure headers have links to all annotations files
# and don't contain links to non-existent header files.
./update-headers.sh

#echo "---------------------------------------------------------"
# Process the "out of stream" corrections.
#./corrections.sh 

## This is obsolete as it modifies the actual annotations
## and not just the GrAF representation.
## echo "---------------------------------------------------------"
## Add missing IDs to sentence annotations.
##./fix-ids.sh  

#echo "---------------------------------------------------------"
# Trim white-space from annotations.
#./fix-alignment.sh #SBI but needs fixing

##echo "---------------------------------------------------------"
## Link the logical annotations into a tree.
##echo "TODO: fix-logical.sh (make-tree.jar) needs fixing"
##./fix-logical.sh

echo "---------------------------------------------------------"
# Link MPQA, NE, NC, and VC annotations to the Penn tokens.
./link-tokens.sh #SBI

echo "---------------------------------------------------------"
# Extract tokens from the PTB and FrameNet files.
# Also links tokens to quarks.
./tokenize.sh #SBI

#echo "---------------------------------------------------------"
# Copy over hand corrected files before validation starts.
#./hand-corrected.sh #not yet present in MASC 2

echo "---------------------------------------------------------"
# Removes leading and trailing whitespace in regions.
./trim.sh

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

echo "---------------------------------------------------------"
# Convert the existing MASC1 files into the new format.
./masc1.sh #SBI

echo "---------------------------------------------------------"
# Perform a schema validation of all document headers and standoff
# annotation files.
./validate.sh data/working/release #SBI

echo "---------------------------------------------------------"
# Generate a summary of the annotations for each file before
# dividing.
groovy ./summarize.groovy ../data/working/release ../
./check-ids.sh
./check-nodes.sh
./check-docid.sh

echo "---------------------------------------------------------"
#echo TODO: The divide.sh and package.sh scripts needs to be updated.
# Divide the files into written and spoken components.
./divide.sh #SBI

echo "---------------------------------------------------------"
# Copies other original annotations, header, etc. and
# packages everything.
./package.sh #SBI

echo "---------------------------------------------------------"
# Copy data to the local corpora directory
./local-copy.sh
