#!/bin/bash

if [ "$1" == "" ] ; then
	echo "USAGE: find-missing.sh <annotation-type>"
	echo ""
	echo "I.E.> ./find-missing.sh ne"
	echo ""
	exit
fi

for t in logical s penn ne nc vc ; do
	for i in `ls ../data/working/release/*.txt` ; do
		file=`echo $i | sed 's/.txt/-'$t'.xml/'`
		if [ ! -e $file ] ; then
			echo `echo $file | sed 's|../data/working/release/||'`
		fi
	done
done