#!/bin/bash

source ./config.sh

set -eu

DEST=$WORK/graf-1.0.0
if [ -e $DEST ] ; then
	rm -rf $DEST
fi
mkdir -p $DEST
groovy convert.groovy $MASC $DEST
