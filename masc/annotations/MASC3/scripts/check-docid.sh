#!/bin/bash

source ./config.sh

echo check-ids.sh

APP=$APPS/check-docid/target/check-docid.jar

if [ -e docid.txt ] ; then
	rm docid.txt
fi

java $OPTS -jar $APP $LOPTS -in=$WORK/release

