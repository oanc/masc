#!/bin/bash

source ./config.sh
set -eu
echo "Running $0"

rm -f data/working/staging/*.*

groovy scripts/fixPennFeatures.groovy

for file in `ls data/working/staging/*-penn.xml` ; do
	filename=`echo $file | cut -d/ -f4`
	echo "Tidying $file"
	tidy -indent -xml -utf8 -o data/working/release/$filename $file > /dev/null
done

echo "Done."