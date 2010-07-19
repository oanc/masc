#!/bin/bash

source ./config.sh

SAXON=../../apps/saxon9he.jar
STYLE=../../scripts/annotations2.xsl
SCHEMA=http://www.anc.org/masc/schema/docheader.xsd

function transform {
	echo Transforming $1
	java $OPTS -jar $SAXON -versionmsg:off -o:../../data/working/headers/$1 $1 $STYLE 
}

function create {
	if [ ! -e $1 ] ; then
		mkdir -p $1
	else
		rm -f $1/*.*
	fi
}

#cd ..

create $WORK/validation
create $WORK/headers

java $OPTS -jar $VALIDATOR -in=$OUT -out=$WORK/validation -schema=$SCHEMA -create -update -change

cd ./data/release
for i in $( ls *.anc) ; do
	transform $i
done
cd ../../

echo Copying headers to $OUT
cp -f $WORK/headers/*.* $OUT
