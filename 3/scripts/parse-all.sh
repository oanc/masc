#!/bin/bash

source ./config.sh

echo running parse-all.sh

#cd ../

PARSER=$APPS/parse-all/target/ParseAll.jar

java $OPTS -jar $PARSER -in=$MASC $LOPTS