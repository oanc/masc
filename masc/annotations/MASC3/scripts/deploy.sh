#!/bin/bash

# Copies the archives to the local machine and to the ANC web server.

echo "Running $0"

LOCAL=/home/www/anc/masc
WEB=suderman@anc.org:$LOCAL

echo "Copying to local corpora directory"
cp -r $RELEASE/data $DEPLOY_DIR
cp $RELEASE/*.xml $DEPLOY_DIR


if [ -e $WEB ] ; then
    # This will (should) only be true 
    # when running on the ANC server.
    echo "Copying archive to web server."
    cp $TGZ $WEB
    cp $ZIP $WEB
else
	echo "Copying files to the ANC server."
	scp -P 22022 $TGZ $WEB
	scp -P 22022 $ZIP $WEB
fi
