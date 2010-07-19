#!/bin/bash

source ./config.sh

#cd ../

PARSER=$APPS/parse-all/target/ParseAll.jar

java $OPTS -jar $PARSER -in=$MASC $LOPTS