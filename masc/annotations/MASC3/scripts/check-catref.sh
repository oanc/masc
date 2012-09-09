#!/bin/bash

source ./config.sh

APP=$APPS/check-catref/target/check-catref.jar

java $OPTS -jar $APP /var/corpora/MASC-3.0.0 ./reports