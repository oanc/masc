#!/bin/bash

source ./config.sh

echo Generating headers.
if [ -d $DATA/headers ] ; then
	rm -f $DATA/headers/*.*
else
	mkdir -p $DATA/headers
fi

echo "CORPORA is $CORPORA"
echo "DATA/headers is $DATA/headers"

JAR=$APPS/masc-headers/target/masc-headers.jar
#java $OPTS -jar $JAR $CORPORA 2 $IN/MASC-MASTER.csv $DATA/headers
java $OPTS -jar $JAR $CORPORA $DATA/headers $METADATA/MASC-MASTER.csv 2

# The above generates MASC 3 headers as well. Copy the MASC 2
# headers into the output directory
groovy scripts/copyheaders.groovy $DATA/headers $OUT
