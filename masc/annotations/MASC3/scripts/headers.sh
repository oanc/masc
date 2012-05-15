#!/bin/bash

source ./config.sh

echo Generating headers.
if [ ! -e $DATA/headers ] ; then
	mkdir -p $DATA/headers
fi

JAR=$APPS/masc-headers/target/masc-headers.jar
java $OPTS -jar $JAR $CORPORA $DROPBOX/MASC2-3/MASC-MASTER.csv $DATA/headers

# Rename the ch3.hdr file.
mv $DATA/headers/ch3.hdr $DATA/headers/rybczynski-ch3.hdr

# The above generates all MASC headers. Copy only the MASC 3
# headers into the output directory
groovy scripts/copyheaders.groovy $DATA/headers $OUT
