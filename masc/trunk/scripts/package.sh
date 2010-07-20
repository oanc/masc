#!/bin/bash

source ./config.sh

DATE=`date +%Y-%m-%d`
VERS=1.0.2

FILENAME="MASC-$VERS-$DATE.tgz"

TGZ=$ROOT/$FILENAME
if [ -e $TGZ ] ; then
	rm -f $TGZ
fi

echo "Creating $TGZ"
#pwd
cd $RELEASE
FILES=
for file in `ls` ; do
	FILES="$file $FILES"
done
tar czf $TGZ $FILES

