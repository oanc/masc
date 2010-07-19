#!/bin/bash

source ./config.sh

JAR=saxon9he.jar
SAXON=$APPS/$JAR
STYLE=$ROOT/scripts/annotations2.xsl
SCHEMA=http://www.anc.org/masc/schema/docheader.xsd

if [ "$CYGWIN" != "" ] ; then
	SAXON=/cygwin/$SAXON
	STYLE=/cygwin/$STYLE
	CYG=/cygwin
fi

function transform {
	HEADER=$CYG/$ROOT/$WORK/headers/$1
	echo Transforming $1 to $HEADER
	pwd
	java $OPTS -jar $SAXON -versionmsg:off -o:$HEADER $1 $STYLE 
}

function create {
	if [ ! -e $1 ] ; then
		echo "Creating $1"
		mkdir -p $1
	else
		echo "Clearing $1"
		rm -f $1/*.*
	fi
}

#cd ..


create $WORK/validation
create $WORK/headers

if [ ! -e $APPS/$JAR ] ; then
	echo "Downloading Saxon."
	pushd $APPS
	wget http://www.anc.org/tools/saxon9he.jar
	popd

	if [ ! -e $SAXON ] ; then
		echo "Saxon download failed."
		exit 1
	fi
fi

#java $OPTS -jar $VALIDATOR -in=$MASC -out=$WORK/validation -schema=$SCHEMA -create -update -change

pushd ./data/data
for i in `ls *.anc` ; do
	transform $i
done
popd

echo Copying headers to $OUT
cp -f $WORK/headers/*.* $OUT

