#!/bin/bash

source ./config.sh

echo check-align.sh

APP=$APPS/check-align/target/check-align.jar

if [  ! -d ./reports ] ; then
	#echo "The reports directory does not exist."
	#exit 2
	mkdir reports
fi

#ls $APP
#echo java $OPTS -jar $APP $LOPTS -in=$RELEASE/data -out=./reports/alignment.html
java $OPTS -jar $APP $LOPTS -in=$WORK/release -out=./reports/alignment.html -header=$METADATA/MASC3-resource-header.xml