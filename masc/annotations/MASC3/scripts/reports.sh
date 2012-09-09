#!/bin/bash

set -e

source ./config.sh

echo Generating reports.

set -u

IDS=$APPS/check-ids/target/check-ids.jar
DOCS=$APPS/check-docid/target/check-docid.jar
NODES=$APPS/check-nodes/target/check-nodes.jar
TOKENS=$APPS/check-tokens/target/check-tokens.jar
HEADERS=$APPS/check-headers/target/check-headers.jar
DOMAINS=$APPS/check-domains/target/check-domains.jar

LOPTS=-level=warn\ -log=release.log\ -append

if [ -e reports ] ; then
	rm -rf reports
fi
mkdir -p reports
mkdir reports/check-tokens
groovy ./scripts/summarize.groovy $RELEASE/data ./reports/annotations.html

java $OPTS -jar $IDS $LOPTS -in=$RELEASE/data -out=./reports/ids.html
java $OPTS -jar $DOCS $LOPTS -in=$RELEASE/data -out=./reports/docid.txt
java $OPTS -jar $NODES $LOPTS -in=$RELEASE/data -out=./reports/check-nodes.txt
java -Xmx2G -jar $TOKENS $LOPTS -in=$RELEASE/data -out=./reports/check-tokens -header=$RELEASE/resource-header.xml
java -Xmx2G -jar $HEADERS $LOPTS -in=$RELEASE/data -out=./reports/check-headers.txt
java $OPTS -jar $DOMAINS $RELEASE ./reports

# Checks file ID formats, checks for missing f.seg elements, checks for missing extents
grate ./scripts/checkTypes.gr8 $RELEASE/data $DROPBOX/MASC2-3/MASC3-resource-header.xml ./reports

echo Looking for missing files.
cd ./scripts
./find-missing.sh > ../reports/missing-annotations.txt
./find-missing-text.sh > ../reports/missing-texts.txt
./find-missing-headers.sh > ../reports/missing-headers.txt

