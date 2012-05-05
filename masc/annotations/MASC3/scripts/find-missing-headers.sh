#!/bin/bash

source ./config.sh

for file in `find $RELEASE/data -type f -name \*.txt` ; do
	header=`echo $file | sed 's/txt/hdr/'`
	if [ ! -e $header ] ; then
		echo $header
	fi
done

