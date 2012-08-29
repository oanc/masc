#!/bin/bash

# set -e causes the script to fail when any command
# fails
set -e

cd ..
ROOT=`pwd`
#echo 'root is $ROOT'

if [ "$CYGWIN" != "" ] ; then
	ROOT=`cygpath -m $ROOT`
fi

# set -u causes the script to fail if an uninitialized
# variable is used.
#set -u

echo "root is" $ROOT

echo

# System specific settings
source ./scripts/$HOSTNAME.sh

VERSION=2.0.0
IN=./data/originals  #original
#IN=./ #updated on 4/26/2011
OUT=./data/data
WORK=./data/working
RELEASE=./data/release
#APPS=$ROOT/apps
APPS=./apps
DATA=./data

# Alias for the release directory for when it is actually
# the input directory and -in=$OUT looks wrong.
MASC=$OUT

# Program names. These should likely be defined in the
# scripts that actually use them.
CONVERT=./apps/convert/target/Convert.jar
ALIGN=./apps/align/target/Align.jar
COPY=./apps/copy-files/target/copy-files.jar

SPLITTER=./apps/graph-splitter/target/graph-splitter.jar
#SPLITTER=./apps/graph-splitter/target/graph-splitter-core-1.0.0-SNAPSHOT.jar
VALIDATOR=./apps/validate-headers/target/ValidateHeaders.jar
CORRECT=./apps/fix-corrections/target/FixCorrections.jar
MAKETREE=./apps/make-tree/target/MakeTree.jar
TRIM=./apps/trim/target/trim.jar

# Location of the fix files used during alignment.
FIX=./apps/align

# JVM options
OPTS=-Xmx800M 

# Logging options
LOPTS=-log=./release.log\ -append\ -level=info

if [ ! -e $APPS ] ; then
	echo "Creating $APPS"
	mkdir -p $APPS
fi

