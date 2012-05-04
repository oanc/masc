#!/bin/bash

source ./config.sh

echo running package.sh

DATE=`date +%Y-%m-%d`
VERS=2.0.0

NAME="MASC-$VERS"

TGZ=$ROOT/$NAME.tgz
ZIP=$ROOT/$NAME.zip
DIR=$CORPORA/$NAME

if [ ! -e $DIR ] ; then
fi

echo "Copying files to local corpora directory"
cp -r $RELEASE $DIR

echo TGZ is $TGZ
if [ -e $TGZ ] ; then
	rm -f $TGZ
fi
if [ -e $ZIP ] ; then
	rm -f $ZIP
fi

echo "Creating $TGZ"
#pwd
cd $RELEASE
FILES=
for file in `ls` ; do
	FILES="$file $FILES"
done
tar czf $TGZ $FILES

echo "Creating $ZIP"
zip -r -9 -q $ZIP .
WEB=/var/www/anc/masc
if [ -e $WEB ] ; then
    # This will (should) only be true 
    # when running on the ANC server.
    echo "Copying archive to web server."
    cp $TGZ $WEB
fi

echo "Packaging complete."

