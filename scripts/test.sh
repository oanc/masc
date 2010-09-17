#!/bin/bash

source ./config.sh

EV=$WORK/event/graf
cp $IN/event/xces/*.txt $EV
rm $EV/A1*.xml
rm $EV/enron-thread*.xml
java $OPTS -jar $ALIGN $LOPTS -src=$EV -target=$MASC -dest=$MASC -type=event -fix=$FIX/event-fixes.xml

echo Test complete.

