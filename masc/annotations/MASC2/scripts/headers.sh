#!/bin/bash

source ./config.sh

echo Generating headers.
JAR=$APPS/masc-headers/target/masc-headers.jar
java $OPTS -jar $JAR D:/Corpora $DATA/headers

# The above generates MASC 3 headers as well. Copy the MASC 2
# headers into the output directory
groovy scripts/copyheaders.groovy $DATA/headers $OUT
