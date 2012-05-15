#!/bin/bash

set -e

source ./config.sh

echo Generating reports.

FILES=docid.txt\ check-nodes.txt\ id.html

IDS=$APPS/check-ids/target/check-ids.jar
DOCS=$APPS/check-docid/target/check-docid.jar
NODES=$APPS/check-nodes/target/check-nodes.jar
LOPTS=-level=warn\ -log=release.log\ -append

for file in $FILES ; do
	if [ -e $file ] ; then
		echo rm $file
	fi
done
#exit

groovy ./scripts/summarize.groovy $RELEASE/data .

java $OPTS -jar $IDS $LOPTS -in=$RELEASE/data -out=ids.html
java $OPTS -jar $DOCS $LOPTS -in=$RELEASE/data
java $OPTS -jar $NODES $LOPTS -in=$RELEASE/data -out=check-nodes.txt

echo Looking for missing files.
cd ./scripts
./find-missing.sh > ../missing-annotations.txt
./find-missing-text.sh > ../missing-texts.txt
./find-missing-headers.sh > ../missing.headers.txt

