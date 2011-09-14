#!/bin/bash

source ./config.sh

echo running fix-ids.sh

#cd ..
APP=./apps/check-ids/target/CheckIds.jar
DEST=./data/working/ids

if [ ! -e $DEST ] ; then
        echo mkdir -p $DEST
	mkdir -p $DEST
else
        echo rm -f $DEST/*.*
	rm -f $DEST/*.*
fi

echo java $OPTS -jar $APP $LOPTS -in=$OUT -out=$DEST -filter=-s.xml
java $OPTS -jar $APP $LOPTS -in=$OUT -out=$DEST -filter=-s.xml

echo cp -f $DEST/*.* $OUT
cp -f $DEST/*.* $OUT

