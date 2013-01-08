#!/bin/bash
source ./config.sh
set -eu

JAR=$APPS/addsegids/target/addsegids.jar
FIXIDS=./scripts/fixIds.gr8
FIXHEADERS=./scripts/CheckAnnotations.gr8

if [ ! -e $FIXIDS ] ; then
	echo "Script not found: $FIXIDS"
	pwd
	exit
fi

#echo "DATA : $DATA"
echo "RELEASE : $RELEASE"
#ls $RELEASE
#groovy ./scripts/fixIds.gr8 $RELEASE 

java $OPTS -jar $JAR $LOPTS -in=$RELEASE/data
grate $FIXIDS $RELEASE
grate $FIXHEADERS $RELEASE
