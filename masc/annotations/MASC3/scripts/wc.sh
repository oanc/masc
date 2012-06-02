#!/bin/bash

# Counts the words in a MASC release.  Calculates the sum of all
# <extent/> elements in the document headers.

TMP=/tmp/extent.txt
MASC2=/var/corpora/MASC-2.0.0/data
MASC3=../data/release/data

function count
{
	if [ ! -e $1 ] ; then
		echo "Corpus $1 not found."
		return
	fi
	
	if [ -e $TMP ] ; then
		rm $TMP
	fi
	
	for file in `find $1 -name \*\.hdr` ; do
		grep extent $file | cut -d \" -f 2 >> $TMP
	done
	NFILES=`cat $TMP | wc -l`
	COUNT=paste -sd+ /tmp/extent.txt | bc
	echo $2
	echo "Files: $NFILES"
	echo "Count: $COUNT"
	echo ""
}
#count $MASC1 Masc1
count $MASC2 Masc2
count $MASC3 Masc3
