#!/bin/bash

# For some reason the Day3PMSession-vc.xml file is using an 
# incorrect file ID (f.id). This file is from MASC 1 and is
# one of the out of stream correction files.  I have no idea
# why only this one file suffers this problem, but we are pressed
# for time and this is the fastest fix for now.
#
# A proper fix for the problem should be found if possible.
#
# KS

source ./config.sh
set -eu

echo "Running $0"

FILENAME=Day3PMSession-vc.xml
DIR=$RELEASE/data/spoken/court-transcript
DAY3=$DIR/$FILENAME
TEMP_FILE=/tmp/$FILENAME

if [ ! -e $DIR ] ; then
	echo "$DIR not found."
	exit
fi

echo "DIR is $DIR"
pwd
for file in `find $DIR -name 'Day3PMSession-*\.xml'` ; do
	echo $file
	filename=`basename $file`
	temp=/tmp/$filename
	sed 's/f.id=\"(.*)\"/f.id=\"f.$1\"/' $file > $temp
	#mv $temp $DIR
done


