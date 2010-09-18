#!/bin/bash

source ./config.sh


EV=$WORK/event/graf
cp $IN/event/xces/*.txt $EV
rm $EV/A1*.xml
rm $EV/enron-thread*.xml
java $OPTS -jar $ALIGN $LOPTS -src=$EV -target=$MASC -dest=$MASC -type=event -fix=$FIX/event-fixes.xml

echo Test complete.
exit 0

GET=`which wget`
if [ "$GET" = "" ] ; then
	echo "wget not available."
	GET=`which curl`
	if [ "$GET" = "" ] ; then
		echo "ERROR: curl not found either. Aborting script."
		exit 1
	fi
fi
echo "Using $GET"
exit 0