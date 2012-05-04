#!/bin/bash

for i in `ls ../data/working/release/*.txt` ; do
	header=`echo $i | sed 's/txt/hdr/'`
	if [ ! -e $header ] ; then
		echo `echo $i | sed 's|../data/working/release/||'`
	fi
done