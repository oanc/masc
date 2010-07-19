#!/bin/bash

source ./config.sh

DATE=`date +%Y-%m-%d`
VERS=1.0.2

FILENAME="MASC-$VERS-$DATE.tgz"

if [ -e $FILENAME ] ; then
	rm -f $FILENAME
fi

echo "Creating $FILENAME"
#pwd
tar czf $FILENAME $RELEASE 

