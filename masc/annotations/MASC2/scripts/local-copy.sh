#!/bin/bash
set -e
echo "Running $0"
source ./config.sh
set -u

# Copy files to the local corpora directory
NAME=MASC-$VERSION
DIR=$CORPORA/$NAME

if [ ! -e $DIR ] ; then
	echo "Creating local corpora directory."
	mkdir $DIR
fi

echo "Copying files from $RELEASE to $DIR"
cp -r $RELEASE/data $DIR
cp $RELEASE/*.xml $DIR

