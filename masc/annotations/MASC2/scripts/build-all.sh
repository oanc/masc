#!/bin/bash

source ./config.sh

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
		svn co https://www.anc.org/dev/$2/branches/masc-2 $1
		cd $1
	fi
	echo Building $1
	mvn package | tee -a $ROOT/maven.log
	cd $ROOT
}


function build_trunk {
	if [ -e $APPS/$1 ] ; then
		cd $APPS/$1
		svn up
	else
		echo Creating $1
		cd $APPS
		mkdir $1
		svn co https://www.anc.org/dev/$2/trunk/ $1
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

build "convert" "GrafConvert"
#exit

# Update 9/9/2011 Everything uses build2 now, that is,
# the masc-1.0.3 tagged versions
build "align" "GrafAlign"
build "check-ids" "check-ids"
build "graph-splitter" "graph-splitter"
build "copy-files" "copy-files"
build "validate-headers" "validate-headers"
build "fix-corrections" "fix-corrections"
build "check-ids" "check-ids"
build "link-tokens" "link-tokens"
build "validator" "validator"
build "make-tree" "make-tree"
build "divide-corpus" "divide-corpus"
build "parse-all" "parse-all"
build "check-align" "check-align"
build "update-headers" "update-headers"
build "masc-headers" "masc-headers"
build_trunk "graf-headers" "graf-headers"

#/tags/masc-1.0.3 

#build2 "graph-splitter" "graph-splitter"
#build2 "check-align" "check-align"

echo Looking for errors.
grep ERROR maven.log
echo Build Complete.
