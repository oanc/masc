#!/bin/bash

echo "fix-dependencies.sh"
source ./config.sh

set -e

if [ -d data/working/staging ] ; then
	rm data/working/staging/*.*
else
	mkdir -p data/working/staging
fi

for file in `ls data/working/release/*.xml` ; do
	barename=`echo $file | cut -d/ -f4`
	echo "Fixing dependencies in $file"
	sed 's/dependsOn f.id="\(.*\)"\/>/dependsOn f.id="f.\1"\/>/' < $file > data/working/staging/$barename
	#echo $file
done
mv data/working/staging/*.* data/working/release
exit

# The remainder of the script is obsolete and is left here for 
# historical purposes only.

JAR=$APPS/fix-dependencies/target/fix-dependencies.jar
IN=$WORK/release
OUT=$WORK/staging
if [ -d $OUT ] ; then
	contents=`ls $OUT`
	if [ -n "$contents" ] ; then	
		rm $OUT/*.*
	fi
else
	mkdir $OUT
fi

java -jar $OPTS -jar $JAR $LOPTS -in=$IN -out=$OUT -header=$METADATA/MASC3-resource-header.xml
contents=`ls $OUT`
if [ -n "$contents" ] ; then
	echo "Copying contents of staging directory to $IN"
	cp $OUT/*.* $IN
else
	echo "The staging directory is empty."
fi