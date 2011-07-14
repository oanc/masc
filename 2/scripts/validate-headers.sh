#!/bin/bash

source ./config.sh

echo running validate-headers.sh



JAR=saxon9he.jar
SAXON=$ROOT/apps/$JAR
STYLE=$ROOT/scripts/annotations2.xsl
SCHEMA=http://www.anc.org/masc/schema/docheader.xsd

#echo Jar   is $JAR
#echo Saxon is $SAXON
#echo Style is $STYLE

if [ "$CYGWIN" != "" ] ; then
	SAXON=/cygwin/$SAXON
	STYLE=/cygwin/$STYLE
	CYG=/cygwin
        #echo root is $ROOT
        #echo CYGWIN is $CYGWIN
fi

function transform {
	HEADER=$ROOT/$WORK/headers/$1
	echo Transforming $1 to $HEADER
        echo "java $OPTS -jar ../../apps/$JAR -versionmsg:off $1 $STYLE > $HEADER"
        java $OPTS -jar ../../apps/$JAR -versionmsg:off $1 $STYLE > $HEADER #temp 2011 05 10
        #java $OPTS -jar ../../apps/saxon9he.jar -versionmsg:off $1 $STYLE > $HEADER #temp 2011 05 10
	#pwd
        #echo "java $OPTS -jar $SAXON -versionmsg:off $1 $STYLE > $HEADER"
	#java $OPTS -jar $SAXON -versionmsg:off $1 $STYLE > $HEADER        
        #java -jar ../../apps/saxon9he.jar
      	#pwd	
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
	# Determine if wget is available, if not use curl to download. At
	# least one of the programs should be available on any system.
	GET=`which wget`
	if [ "$GET" = "" ] ; then
		echo "wget not available."
		GET=`which curl`
		if [ "$GET" = "" ] ; then
			echo "ERROR: curl not found either. Aborting script."
			exit 1
		fi
	fi
	pushd $APPS
	$GET http://www.anc.org/tools/saxon9he.jar
	popd

	if [ ! -e $SAXON ] ; then
		echo "Saxon download failed."
		exit 1
	fi
fi

#echo "$APPS/$JAR"
#echo "$SAXON"

#echo "java $OPTS -jar $VALIDATOR -in=$MASC -out=$WORK/validation -schema=$SCHEMA -create -update -change"
java $OPTS -jar $VALIDATOR -in=$MASC -out=$WORK/validation -schema=$SCHEMA -create -update -change

pushd ./data/data
for i in `ls *.anc` ; do
	transform $i
done
popd

echo Copying headers to $OUT
cp -f $WORK/headers/*.* $OUT

echo Jar   is $JAR
echo Saxon is $SAXON
echo Style is $STYLE