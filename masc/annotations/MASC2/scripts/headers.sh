#!/bin/bash

source ./config.sh

echo Generating headers.
rm -f $DATA/headers/*.*
echo "CORPORA is $CORPORA"

JAR=$APPS/masc-headers/target/masc-headers.jar
#java $OPTS -jar $JAR $CORPORA 2 $IN/MASC-MASTER.csv $DATA/headers
java $OPTS -jar $JAR $CORPORA $DATA/headers $METADATA/MASC-MASTER.csv 2

# The above generates MASC 3 headers as well. Copy the MASC 2
# headers into the output directory
groovy scripts/copyheaders.groovy $DATA/headers $OUT
