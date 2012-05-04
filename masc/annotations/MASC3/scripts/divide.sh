#!/bin/bash

echo running divide.sh

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

if [ ! -e $RELEASE/data ] ; then
	mkdir $RELEASE/data
fi

groovy scripts/divide.groovy $DROPBOX/MASC2-3/FULL_MASC $WORK/release $RELEASE/data
HEADER=$DROPBOX/MASC2-3/MASC3-resource-header.xml
if [ -e $HEADER ] ; then
	cp $HEADER $RELEASE
else
	echo "No resource header found."
fi

echo "Done."
