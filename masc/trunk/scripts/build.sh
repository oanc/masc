#!/bin/bash

source ./config.sh

# Build a single project used when processing MASC

if [ ! -e $ROOT/apps/$1 ] ; then
	mkdir $ROOT/apps/$1
	cd $ROOT/apps/$1
	svn co https://www.anc.org/dev/$1/trunk .
fi

cd $ROOT/apps/$1
svn up
mvn clean package
cd ../../
