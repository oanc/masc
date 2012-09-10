#!/bin/bash
set -e 

# Perform all the steps necessary to process the MASC 1 files for MASC 2.

# Clean up from previous runs and create required directories.
./setup.sh

# Check if we are supposed to rebuild the applications.
if [ "$1" = "build" ] ; then
	#./build-all.sh
	./build2.sh
fi

# Process the existing XCES annotations.
./prep2.sh

# Process MPQA/Opinion corpus
./mpqa.sh

# Process committed belief annotations.
./cb.sh

# Process event annotations.
./event.sh

# Convert and align the Penn Tree Bank files.
./ptb.sh

# Convert and align the FrameNet files.
./framenet.sh

# Process the "out of stream" corrections.
./corrections2.sh

# Add missing IDs to sentence annotations.
./fix-ids.sh

# Extract tokens from the PTB and FrameNet files.
# Also links tokens to quarks.
./tokenize.sh

# Make sure headers have links to all annotations files
# and don't contain links to non-existent header files.
./validate-headers.sh

# Link the logical annotations into a tree.
#./fix-logical.sh

# Link NE, NC, and VC annotations to the PTB tokens.
./link-tokens.sh

# Copy over hand corrected files before validation starts.
#./hand-corrected.sh

# Perform a schema validation of all XML files.
./validate.sh

# Run all annotation files through the GraphParser
./parse-all.sh

# Check annotation alignment, that is whitespace at the
# start or end of an annotation.
./check-align.sh

# Convert to the lastest (1.0.0) GrAF format.
./convert.sh

# Divide the files into written and spoken components.
./divide.sh

# Copies other original annotations, header, etc. and
# packages everything.
./package.sh

# Deploy to local corpora directory
./local-copy.sh
