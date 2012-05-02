#!/bin/bash

source ./config.sh

# Build a single project used when processing MASC

if [ "$APPS" = "" ] ; then
	echo "APPS not set."
	exit 1
fi

TARGET=$APPS/$1
echo Target is $TARGET
#exit 1

if [ ! -e $TARGET ] ; then
	mkdir $TARGET
	pushd $TARGET
	echo "Target is"
	pwd	
	svn co https://www.anc.org/dev/$1/branches/masc-2 .
else
	pushd $TARGET
	svn up
fi
mvn clean package
popd
