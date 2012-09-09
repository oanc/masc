#!/bin/bash

source ./config.sh

echo running setup.sh

# Sets up the processing environment including downloading
# annotations and creating all required directories.

function createDir {
	echo Creating directory $1
	mkdir -p $1
}

# Get/update the original MASC annotations.
if [ -e $IN ] ; then
	echo "Checking Subversion for data updates."
	cd $IN
	svn up
else
	mkdir -p $IN
	echo "Checking data out of Subversion."
	cd $IN
    svn co https://www.anc.org/dev/masc/annotations/MASC3edit c .
fi

if [ -e $DATA/headers ] ; then
	rm -f $DATA/headers/*.*
fi

cd $ROOT

# Remove any files from previous runs
rm -f *.log
if [ -e $OUT ] ; then
	echo Deleting data from previous runs.
	rm -rf $OUT
fi
if [ -e $WORK ] ; then
	echo Deleting working data from $WORK
	rm -rf $WORK
fi
if [ -e $RELEASE ] ; then
	echo Deleting previous release data from $RELEASE
	rm -rf $RELEASE
fi
if [ -e reports ] ; then
	echo "Deleting previous run reports."
	rm -f reports/*.*
fi
# Create the build environment
#mkdir -p $OUT
#mkdir -p $WORK

#mkdir -p $WORK/ptb
#mkdir -p $WORK/framenet
#mkdir -p $WORK/tokens/ptb
#mkdir -p $WORK/tokens/fn
#mkdir -p $WORK/tokens/quarks

createDir $OUT
createDir $WORK
createDir $WORK/ptb
createDir $WORK/mpqa
createDir $WORK/framenet
createDir $WORK/release
createDir $WORK/tokens/fn
createDir $WORK/tokens/ptb
createDir $WORK/tokens/quarks
createDir $RELEASE
