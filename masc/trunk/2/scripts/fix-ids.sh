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

java $OPTS -jar $APP $LOPTS -in=$OUT -out=$DEST -filter=-s.xml
cp -f $DEST/*.* $OUT

