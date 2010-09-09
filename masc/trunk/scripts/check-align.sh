#!/bin/bash

source ./config.sh

APP=$APPS/check-align/target/check-align.jar

ls $APP
java $OPTS -jar $APP $LOPTS -in=$MASC -out=alignment.html
