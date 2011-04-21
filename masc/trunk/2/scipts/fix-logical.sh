#!/bin/bash

source ./config.sh

APP=./apps/make-tree/target/MakeTree.jar
DEST=$WORK/logical

if [ -e $DEST ] ; then
	rm -f $DEST/*.*
else
	mkdir $DEST
fi

java $OPTS -jar $APP -in=$OUT -out=$DEST -atype=logical $LOPTS
cp $DEST/*.* $OUT
