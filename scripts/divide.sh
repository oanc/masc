#!/bin/bash

set -e
echo "Running $0"
function check {
	if [ ! -e $1 ] ; then
		echo "$1 not found"
		exit 1
	fi
}

function clean {
    if [ -e $1 ] ; then
		rm -f $1/*.*
    else
		mkdir -p $1
    fi
}

source ./config.sh

# Where files will be copied to.
WRITTEN=$RELEASE/data/written
SPOKEN=$RELEASE/data/spoken
# Program to do the copying
APP=$APPS/divide-corpus/target/divide-corpus.jar
BAK=./data/bak
# Location of the files to divy up.
IN=$WORK/graf-1.0.0

# Make sure we have everything.
check $IN
check $APP

# Clean up from previous runs.
clean $RELEASE
clean $WRITTEN
clean $SPOKEN

echo "Dividing corpus."

java $OPTS -jar $APP $LOPTS -in=$IN -written=$WRITTEN -spoken=$SPOKEN

# Now move over the original annotations and Corpus header
ORG=./data/originals/original-annotations
HEADER=./data/originals/MASC-corpus-header.xml

echo "Copying original annotations."
cp -Rf $ORG $RELEASE
cp -f $HEADER $RELEASE/resource-header.xml

# Remove the SVN metadata
rm -Rf $RELEASE/original-annotations/.svn
rm -Rf $RELEASE/original-annotations/*/.svn

echo "Done."
