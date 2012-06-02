#!/bin/bash

echo running divide.sh

source ./config.sh
HEADER=$DROPBOX/MASC2-3/MASC3-resource-header.xml

if [ ! -e $RELEASE/data ] ; then
	mkdir $RELEASE/data
fi

groovy scripts/divide.groovy $DROPBOX/MASC2-3/FULL_MASC $WORK/release $RELEASE/data
if [ -e $HEADER ] ; then
	echo "Copying $HEADER to $RELEASE"
	cp $HEADER $RELEASE/resource-header.xml
else
	echo "No resource header found at $HEADER"
fi

echo "Done."
exit 

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

