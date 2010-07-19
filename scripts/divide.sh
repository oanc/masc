#!/bin/bash

function check {
	if [ ! -e $1 ] ; then
		echo "$1 not found"
		exit 1
	fi
}

function clean {
    if [ -e $1 ] ; then
	rm -f $1/*.*
    else
	mkdir -p $1
    fi
}

source ./config.sh

cd $ROOT

WRITTEN=$RELEASE/written
SPOKEN=$RELEASE/spoken
APP=$APPS/divide-corpus/target/divide-corpus.jar
BAK=./data/bak

check $APP
clean $RELEASE
clean $BAK
clean $WRITTEN
clean $SPOKEN

echo "Making backup copy of files."
cp $MASC/* $BAK 

echo "Dividing corpus."
java $OPTS -jar $APP $LOPTS -in=$MASC -written=$WRITTEN -spoken=$SPOKEN

# Now move over the original annotations and Corpus header
ORG=./data/originals

echo "Copying original annotations."
cp -R $ORG $RELEASE
mv $ORG/MASC-corpus-header.xml $RELEASE
