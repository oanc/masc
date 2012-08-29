#!/bin/bash
set -eu

# Copy the data to the local corpora directory

source ./config.sh

echo "Copying files to the Corpora directory."
CORPORA=/var/corpora/MASC-$VERSION
if [ -e $CORPORA ] ; then
	echo "Removing existing data from $CORPORA"
	rm -rf $CORPORA
fi
mkdir $CORPORA

cp -rf $RELEASE/data $CORPORA/data
cp $RELEASE/resource-header.xml $CORPORA
