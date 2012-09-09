#!/bin/bash

source ./config.sh

echo check-nodes.sh

if [ "$1" == "" ] ; then
	OUTFILE=check-nodes.txt
else
	OUTFILE=$1
fi

APP=$APPS/check-nodes/target/check-nodes.jar

if [ -f $OUTFILE ] ; then
	rm $OUTFILE
fi

java $OPTS -jar $APP $LOPTS -in=$RELEASE/data -out=$OUTFILE
#java $OPTS -jar $APP $LOPTS -in=$WORK/release -out=$OUTFILE
#java $OPTS -jar $APP -level=debug -in=$WORK/release -out=ids.html

