#!/bin/bash

# This script fetches all the code needed to process MASC from Subversion
# and then builds everything with Maven.

source ./config.sh

SVN_ROOT=https://www.anc.org/dev

case $VERSION in
	2|2.*)
		VERSION=2
		;;
esac
	
SVN_BRANCH=branches/masc-$VERSION

# Get the code for a Java program used during processing. 
function co {
	if [ -e $APPS/$1 ] ; then
		echo "Project already exists. Updating $1"
		cd $APPS/$1
		svn up
	else
		echo "Creating $1"
		cd $APPS
		mkdir $1
		svn co $SVN_ROOT/$2/$SVN_BRANCH $1
		cd $1
	fi
	echo "Building $1"
	mvn package | tee -a $ROOT/maven.log
	cd $ROOT
}

#echo "Root is $ROOT"
if [ -e $ROOT/maven.log ] ; then
    rm -f $ROOT/maven.log
fi
touch $ROOT/maven.log

co "convert" "GrafConvert"
co "align" "GrafAlign"
co "check-ids" "check-ids"
co "graph-splitter" "graph-splitter"
co "copy-files" "copy-files"
co "validate-headers" "validate-headers"
#build "fix-corrections" "fix-corrections"
co "check-ids" "check-ids"
co "link-tokens" "link-tokens"
co "validator" "validator"
#build "make-tree" "make-tree"
co "divide-corpus" "divide-corpus"
co "parse-all" "parse-all"
co "trim" "trim"
co "check-align" "check-align"
co "update-headers" "update-headers"
#build "masc-headers" "masc-headers"
co "check-nodes" "check-nodes"
co "check-docid" "check-docid"
co "check-headers" "check-headers"
co "check-tokens" "check-tokens"
co "load-all" "load-all"
co "addsegids" "addsegids"

echo Looking for errors.
grep ERROR maven.log
echo Build Complete.
