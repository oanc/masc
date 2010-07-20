#!/bin/bash

# Perform all the steps necessary to process the MASC files.

# Clean up from previous runs and create required directories.
./setup.sh

# Check if we are supposed to rebuild the applications.
if [ "$1" = "build" ] ; then
	./build-all.sh
fi

# Process the existing XCES annotations.
./prep.sh

# Convert and align the Penn Tree Bank files.
./ptb.sh

# Convert and align the FrameNet files.
./framenet.sh

# Process the "out of stream" corrections.
./corrections.sh
#exit 0

# Add missing IDs to sentence annotations.
./fix-ids.sh

# Extract tokens from the PTB and FrameNet files.
# Also links tokens to quarks.
./tokenize.sh

# Make sure headers have links to all annotations files
# and don't contain links to non-existent header files.
./validate-headers.sh

# Not is SVN yet.
# Link the logical annotations into a tree.
./fix-logical.sh

# Link NE, NC, and VC annotations to the PTB tokens.
./link-tokens.sh

# Perform a schema validation of all XML files.
./validate.sh

# Run all annotation files through the GraphParser
./parse-all.sh

# Divide the files into written and spoken components.
./divide.sh

# Copies other original annotations, header, etc. and
# packages everything.
./package.sh
