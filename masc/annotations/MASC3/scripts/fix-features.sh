#!/bin/bash

echo Running $0

source ./config.sh
set -eu

groovy scripts/FixFeatureValues.groovy $RELEASE/data
exit

# Dead code below. A simple `sed` replacement doesn't work.
TEMP_DIR=/tmp/fixed-features
if [ ! -e $TEMP_DIR ] ; then
	mkdir $TEMP_DIR
fi

for file in `find $RELEASE/data -type f -name '*.xml'` ; do
	echo "Fixing $file"
	base=`basename $file`
	cat $file | sed 's/<f name=\"\(.*\)\">\(.*\)<\/f>/<f name=\"\1\" value=\"\2\"\/>/' > $TEMP_DIR/$base
	mv $TEMP_DIR/$base $file
done

