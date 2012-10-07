#!/bin/bash

source ./config.sh

echo "Running $0"

if [ ! -e $DIR ] ; then
	mkdir -p $DIR
fi

echo TGZ is $TGZ
if [ -e $TGZ ] ; then
	rm -f $TGZ
fi
if [ -e $ZIP ] ; then
	rm -f $ZIP
fi

echo "Creating $TGZ"
cd $RELEASE
FILES=
for file in `ls` ; do
	FILES="$file $FILES"
done
tar czf $TGZ $FILES

echo "Creating $ZIP"
zip -r -9 -q $ZIP .

#echo "Early termination."
#exit

echo "Packaging complete."

