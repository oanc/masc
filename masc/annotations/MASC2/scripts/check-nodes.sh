#!/bin/bash

source ./config.sh

echo check-ids.sh

if [ "$1" == "" ] ; then
	OUTFILE=check-nodes.txt
else
	OUTFILE=$1
fi

APP=$APPS/check-nodes/target/check-nodes.jar

if [ -f check-nodes.txt ] ; then
	rm check-nodes.txt
fi

java $OPTS -jar $APP $LOPTS -in=$WORK/release -out=$OUTFILE
#java $OPTS -jar $APP -level=debug -in=$WORK/release -out=ids.html

