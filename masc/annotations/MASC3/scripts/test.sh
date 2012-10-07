#!/bin/bash

source ./config.sh
echo "RELEASE: $RELEASE"
echo "WORK   : $WORK"
echo "DATA   : $DATA"
echo "MASC   : $MASC"
echo "OUT    : $OUT"
echo "IN     : $IN"

if [ -z "$SPLITTER" ] ; then
	echo "SPLITTER is not defined."
else
	echo "SPLITTER: $SPLITTER"
fi

