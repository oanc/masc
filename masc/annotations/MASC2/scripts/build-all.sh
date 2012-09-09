#!/bin/bash

source ./config.sh
set -e

UPDATE="false"
if [ "$1" = "-up" ] ; then
	UPDATE="true"
fi

if [ -f $ROOT/maven.log ] ; then
	rm -f $ROOT/maven.log
fi

cd $APPS
for dir in `ls -d */`; do 
	cd $dir
	if  [ -f pom.xml ] ; then
		if [ -d .svn ] && [ "$UPDATE" = "true" ] ; then
			svn up
		fi
		mvn clean package | tee -a $ROOT/maven.log
	fi
	cd ..
done

echo "Searching for errors."
grep ERROR $ROOT/maven.log

echo "Done."

exit

# The code below this point is the "old way" of performing a build-all.
# It is kept for posterity. The bit that handles getting the code from
# Subversion is handled by the checkout.sh script.

SVN_ROOT=https://www.anc.org/dev
SVN_BRANCH=branches/masc-$VERSION

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
		svn co $SVN_ROOT/$2/$SVN_BRANCH $1
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
		svn co $SVN_ROOT/$2/trunk/ $1
		cd $1
	fi
	echo Building $1
	mvn package | tee -a $ROOT/maven.log
	cd $ROOT
}

#echo "Root is $ROOT"
if [ -e $ROOT/maven.log ] ; then
    rm -f $ROOT/maven.log
fi
touch $ROOT/maven.log

build "convert" "GrafConvert"
#exit

# Update 5/9/2012 Everything uses masc-3.0.0 branch
build "align" "GrafAlign"
build "check-ids" "check-ids"
build "graph-splitter" "graph-splitter"
build "copy-files" "copy-files"
build "validate-headers" "validate-headers"
#build "fix-corrections" "fix-corrections"
build "check-ids" "check-ids"
build "link-tokens" "link-tokens"
build "validator" "validator"
#build "make-tree" "make-tree"
build "divide-corpus" "divide-corpus"
build "parse-all" "parse-all"
build "trim" "trim"
build "check-align" "check-align"
build "update-headers" "update-headers"
#build "masc-headers" "masc-headers"
build "check-nodes" "check-nodes"
build "check-docid" "check-docid"
build "check-headers" "check-headers"
build "check-tokens" "check-tokens"
build "load-all" "load-all"
build "addsegids" "addsegids"

#build_trunk "graf-headers" "graf-headers"

#/tags/masc-1.0.3 

#build2 "graph-splitter" "graph-splitter"
#build2 "check-align" "check-align"

echo Looking for errors.
grep ERROR maven.log
echo Build Complete.
