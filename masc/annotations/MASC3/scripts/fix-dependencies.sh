#!/bin/bash

echo "fix-dependencies.sh"
source ./config.sh

set -e

JAR=$APPS/fix-dependencies/target/fix-dependencies.jar
IN=$WORK/release
OUT=$WORK/staging
if [ -d $OUT ] ; then
	rm $OUT/*.*
else
	mkdir $OUT
fi

java -jar $OPTS -jar $JAR $LOPTS -in=$IN -out=$OUT -header=$METADATA/MASC3-resource-header.xml
cp $OUT/*.* $IN