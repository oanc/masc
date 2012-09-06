#!/bin/bash
# Do not use "set -e", some scripts need to check error conditions.

# Current MASC version being generated.
VERSION=3.0.0

cd ..
ROOT=`pwd`
#echo 'root is $ROOT'

if [ "$CYGWIN" != "" ] ; then
	ROOT=`cygpath -m $ROOT`
fi

# Do not use set -u. Some scripts need to check if command line parameters
# have been passed in.
#set -u

# System specific settings
source ./scripts/$HOSTNAME.sh

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
OPTS="-Xmx500M -Xshare:off -XX:+HeapDumpOnOutOfMemoryError"

# Logging options
LOPTS=-log=./release.log\ -append\ -level=info

if [ ! -e $APPS ] ; then
	echo "Creating $APPS"
	mkdir -p $APPS
fi

