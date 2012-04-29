#!/bin/bash
set -e

source ./config.sh

# Script to build the programs to process the MASC 1 files for MASC 2.

# Build a Java program used during processing.  If the project
# exists locally it will be updated from the Subversion respository,
# otherwise the code will be checked out of the repository.
function build {
	if [ -e $APPS/$1 ] ; then
		echo Updating $1
		cd $APPS/$1
		svn up
	else
		echo Creating $1
		cd $APPS
		echo "Current directory is "
		pwd
		mkdir $1
		svn co https://www.anc.org/dev/$2/$3 $1
		cd $1
	fi
	echo Building $1
	mvn package | tee -a $ROOT/maven.log
	cd $ROOT
}

echo "Root i $ROOT"
if [ -e $ROOT/maven.log ] ; then
    rm -f $ROOT/maven.log
fi
touch $ROOT/maven.log

build "convert" "GrafConvert" "branches/masc-2"
build "link-tokens" "link-tokens" "branches/masc-2"
build "check-ids" "check-ids" "branches/masc-1.0.4"
#exit

build "align" "GrafAlign" "tags/masc-1.0.3"
build "graph-splitter" "graph-splitter" "tags/masc-1.0.3"
build "copy-files" "copy-files" "tags/masc-1.0.3"
build "validate-headers" "validate-headers" "tags/masc-1.0.3"
build "fix-corrections" "fix-corrections" "tags/masc-1.0.3"
build "check-ids" "check-ids" "tags/masc-1.0.3"
build "validator" "validator" "tags/masc-1.0.3"
build "make-tree" "make-tree" "tags/masc-1.0.3"
build "divide-corpus" "divide-corpus" "tags/masc-1.0.3"
build "parse-all" "parse-all" "tags/masc-1.0.3"
build "check-align" "check-align" "tags/masc-1.0.3"

echo Looking for errors.
grep ERROR maven.log
echo Build Complete.
