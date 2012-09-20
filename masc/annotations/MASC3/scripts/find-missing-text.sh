#!/bin/bash

set -e

source ./config.sh

path=$METADATA/FULL_MASC
masc=$RELEASE/data
text=$IN/txtfiles

for txt in `find $path -type f -name \*.txt` ; do
	file=`echo $txt | sed 's|'$path'|'$masc'|'`
	#base=`basename $txt`
	if [ ! -e $file ] ; then
		echo `basename $file`
	fi
done