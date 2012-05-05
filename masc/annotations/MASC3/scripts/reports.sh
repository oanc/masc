#!/bin/bash

set -e

source ./config.sh

echo Generating reports.

IDS=$APPS/check-ids/target/check-ids.jar
DOCS=$APPS/check-docid/target/check-docid.jar
NODES=$APPS/check-nodes/target/check-nodes.jar

if [ -e docid.txt ] ; then
	rm docid.txt
fi

if [ -e id.html ] ; then
	rm id.html
fi

if [ -f check-nodes.txt ] ; then
	rm check-nodes.txt
fi

groovy ./scripts/summarize.groovy $RELEASE/data .

java $OPTS -jar $IDS $LOPTS -in=$RELEASE/data -out=ids.html
java $OPTS -jar $DOCS $LOPTS -in=$RELEASE/data
java $OPTS -jar $NODES $LOPTS -in=$RELEASE/data -out=check-nodes.txt
