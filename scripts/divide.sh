#!/bin/bash

source ./config.sh

cd $ROOT

APP=./apps/divide-corpus/target/divide-corpus.jar

WRITTEN=$RELEASE/written
SPOKEN=$RELEASE/spoken

function clean {
    if [ -e $1 ] ; then
	rm -f $1/*.*
    else
	mkdir -p $1
    fi
}

clean $WRITTEN
clean $SPOKEN

java $OPTS -jar $APP -in=$MASC -written=$WRITTEN -spoken=$SPOKEN

