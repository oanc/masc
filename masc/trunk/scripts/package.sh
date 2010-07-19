#!/bin/bash

source ./config.sh

DATE=`date +%Y-%m-%d`
VERS=1.0.2

FILENAME="MASC-$VERS-$DATE.tgz"

echo "Creating $FILENAME"
tar czf $RELEASE $FILENAME

