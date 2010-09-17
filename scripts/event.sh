#!/bin/bash

# This script is used for testing and in not
# part of the MASC processing pipeline.

source ./config.sh

# Convert and align the event data.
EV=$WORK/event/graf
if [ -e $EV ] ; then
	rm -rf $EV
fi
mkdir $EV
cp $IN/event/xces/*.txt $EV
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=event -in=$IN/event/xces -out=$EV -saveAs=event -id=ev
# The A1 files and enron-thread are invalid so we don't process them.
rm $EV/A1*.xml
rm $EV/enron-thread*.xml
java $OPTS -jar $ALIGN $LOPTS -src=$EV -target=$MASC -dest=$MASC -type=event -fix=$FIX/event-fixes.xml

# Align the opinion data
java $OPTS -jar $ALIGN $LOPTS -src=$IN/opinion/graf -target=$OUT -dest=$OUT -type=mpqa -fix=$FIX/opinion-fixes.xml
