#!/bin/bash
source ./config.sh
set -eu

JAR=$APPS/addsegids/target/addsegids.jar

#echo "DATA : $DATA"
echo "RELEASE : $RELEASE"
#ls $RELEASE
#groovy ./scripts/fixIds.gr8 $RELEASE 

java $OPTS -jar $JAR $LOPTS -in=$RELEASE/data
