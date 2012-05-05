#!/bin/bash

source ./config.sh

echo "Copying MASC2 files to the release directory."
cp -r $CORPORA/MASC-2.0.0/data $RELEASE
