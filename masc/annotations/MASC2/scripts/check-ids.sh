#!/bin/bash

source ./config.sh

echo check-ids.sh

APP=$APPS/check-ids/target/check-ids.jar
#DOCID=$APPS/check-docid/target/check-docid.jar

if [ -e id.html ] ; then
	rm id.html
fi

java $OPTS -jar $APP $LOPTS -in=$WORK/release -out=ids.html
#java $OPTS -jar $DOCID $LOPTS -in=$RELEASE/data
#java $OPTS -jar $APP -level=debug -in=$WORK/release -out=ids.html

