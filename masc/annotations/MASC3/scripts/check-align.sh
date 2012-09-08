#!/bin/bash

source ./config.sh

echo check-align.sh

APP=$APPS/check-align/target/check-align.jar

ls $APP
echo java $OPTS -jar $APP $LOPTS -in=$RELEASE/data -out=./reports/alignment.html
java $OPTS -jar $APP $LOPTS -in=$OUT -out=./reports/alignment.html