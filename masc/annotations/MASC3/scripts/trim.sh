#!/bin/bash

set -e

source ./config.sh

echo trim.sh

#TEMP=/tmp/masc3-trim
#if [ -e $TEMP ] ; then
#	rm -rf $TEMP
#fi

#mkdir -p $TEMP

#pwd
echo $TRIM
java $OPTS -jar $TRIM $LOPTS -in=$OUT -out=$OUT
