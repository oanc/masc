#!/bin/bash
echo running package.sh
set -e
source ./config.sh
set -u

DATE=`date +%Y-%m-%d`
NAME="MASC-$VERSION"

TGZ=$ROOT/$NAME.tgz
ZIP=$ROOT/$NAME.zip

echo TGZ is $TGZ
if [ -e $TGZ ] ; then
	rm -f $TGZ
fi
if [ -e $ZIP ] ; then
	rm -f $ZIP
fi

echo "Creating $TGZ"
cd $RELEASE
FILES=
for file in `ls` ; do
	FILES="$file $FILES"
done
tar czf $TGZ $FILES

echo "Creating $ZIP"
zip -r -9 -q $ZIP .

# If this is run on the web server we copy the files to the download directory.
WEB=/var/www/anc/masc
if [ -d $WEB ] ; then
    # This will (should) only be true 
    # when running on the ANC server.
    echo "Copying archive to web server."
    cp $TGZ $WEB
fi

echo "Packaging complete."

