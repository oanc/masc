#!/bin/bash

source ./config.sh

cd ../

PARSER=./apps/parse-all/target/ParseAll.jar

java $OPTS -jar $PARSER -in=$MASC $LOPTS