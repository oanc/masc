#!/bin/bash

source ./config.sh
set -eu

if [ ! -d /tmp/ne ] ; then
	mkdir /tmp/ne
fi

for f in `find $IN -name '*\.anc'` ; do
	echo "Fixing NE in $f"
	name=`basename $f`
	cat $f | sed -e 's/NE.xml/ne.xml/' -e 's/NE\"/ne\"/' > /tmp/ne/$name
	cp /tmp/ne/$name $f 
	#cat $f | sed 's/NE\"/ne\"' > $f 
done

echo Done.