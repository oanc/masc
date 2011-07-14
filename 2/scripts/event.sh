#!/bin/bash

source ./config.sh

echo running event.sh

# Convert and align the event data.
EV=$WORK/event/graf
if [ -e $EV ] ; then
        echo rm -rf $EV
	rm -rf $EV
fi
mkdir -p $EV

echo cp cp $IN/event/xces/*.txt $EV
cp $IN/event/xces/*.txt $EV

echo java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=event -in=$IN/event/xces -out=$EV -saveAs=event -id=ev
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=event -in=$IN/event/xces -out=$EV -saveAs=event -id=ev

# The A1 files and enron-thread are invalid so we don't process them.
echo rm $EV/A1*.xml
rm $EV/A1*.xml

echo rm $EV/enron-thread*.xml
rm $EV/enron-thread*.xml

echo java $OPTS -jar $ALIGN $LOPTS -src=$EV -target=$MASC -dest=$MASC -type=event -fix=$FIX/event-fixes.xml
java $OPTS -jar $ALIGN $LOPTS -src=$EV -target=$MASC -dest=$MASC -type=event -fix=$FIX/event-fixes.xml
