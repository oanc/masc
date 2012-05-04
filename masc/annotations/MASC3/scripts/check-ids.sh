#!/bin/bash

source ./config.sh

echo check-ids.sh

APP=$APPS/check-ids/target/check-ids.jar

if [ -e id.html ] ; then
	rm id.html
fi

#java $OPTS -jar $APP $LOPTS -in=$RELEASE/data -out=ids.html
java $OPTS -jar $APP $LOPTS -in=$WORK/release -out=ids.html

