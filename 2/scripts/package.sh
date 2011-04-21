#!/bin/bash

source ./config.sh

DATE=`date +%Y-%m-%d`
VERS=1.0.3

#FILENAME="MASC-$VERS-$DATE.tgz"
FILENAME="MASC-$VERS.tgz"

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
echo "Creating tar file."
tar czf $TGZ $FILES

WEB=/var/www/anc/masc
if [ -e $WEB ] ; then
    # This will (should) only be true 
    # when running on the ANC server.
    echo "Copying archive to web server."
    cp $TGZ $WEB
fi

echo "Packaging complete."

