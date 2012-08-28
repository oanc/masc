#!/bin/bash

source ./config.sh

echo check-align.sh

APP=$APPS/check-align/target/check-align.jar

ls $APP
java $OPTS -jar $APP $LOPTS -in=$RELEASE/data -out=alignment.html
