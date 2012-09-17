#!/bin/bash

source ./config.sh
#cd ..

APP=./apps/check-ids/target/CheckIds.jar
DEST=./data/working/ids

if [ ! -e $DEST ] ; then
	mkdir -p $DEST
else
	rm -f $DEST/*.*
fi

# The name of the jar varies depending on the Subversion branch.
if [ -f $APP ] ; then
	java $OPTS -jar $APP $LOPTS -in=$OUT -out=$DEST -filter=-s.xml -id=s
else
	APP=./apps/check-ids/target/check-ids.jar
	if [ ! -f $APP ] ; then
		echo "Unable to find the jar file for the check-ids application."
		exit 1
	fi
	java $OPTS -jar $APP $LOPTS -in=$OUT -out=$DEST #-filter=-s.xml -id=s
fi
cp -f $DEST/*.* $OUT

