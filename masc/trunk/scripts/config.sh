#!/bin/bash

ROOT=$HOME/masc-ci

#if [ "$TERM" = "cygwin" ] ; then
#	CYGROOT=/cygwin$ROOT
#else
#	CYGROOT-$ROOT
#fi

IN=./data/originals
OUT=./data/data
WORK=./data/working
RELEASE=./data/release

# Alias for the release directory for when it is actually
# the input directory and -in=$OUT looks wrong.
MASC=$OUT

# Program names. These should likely be defined in the
# scripts that actually use them.
CONVERT=./apps/convert/target/Convert.jar
ALIGN=./apps/align/target/Align.jar
COPY=./apps/copy-files/target/copy-files.jar
SPLITTER=./apps/graph-splitter/target/graph-splitter.jar
VALIDATOR=./apps/validate-headers/target/ValidateHeaders.jar
CORRECT=./apps/fix-corrections/target/FixCorrections.jar
MAKETREE=./make-tree/target/MakeTree.jar

# Location of the fix files used during alignment.
FIX=./apps/align

# JVM options
OPTS=-Xmx800M 

# Logging options
LOPTS=-log=./release.log\ -append\ -level=info

