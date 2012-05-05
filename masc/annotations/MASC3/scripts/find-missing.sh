#!/bin/bash

#if [ "$1" == "" ] ; then
#	echo "USAGE: find-missing.sh <annotation-type>"
#	echo ""
#	echo "I.E.> ./find-missing.sh ne"
#	echo ""
#	exit
#fi

echo "Looking for missing annotation files."
set -e
source ./config.sh

for file in `find $RELEASE/data -type f -name \*.txt` ; do
	for type in logical s penn ne nc vc ; do
		so=`echo $file | sed 's/.txt/-'$type'.xml/'`
		if [ ! -e $so ] ; then
			#echo `echo $so | sed 's|../data/working/release/||'`
			echo $so
		fi
	done
done


