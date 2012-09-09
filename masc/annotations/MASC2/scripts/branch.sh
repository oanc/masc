#!/bin/bash
source ./config.sh
REPO="https://www.anc.org/dev"

function usage
{
	echo "USAGE: $0 [tag|branch]"
	echo
	echo "Creates a new branch or tag for all code in the $APPS directory. Current"
	echo "MASC version is $VERSION. "
}


function branch {
	app=$1
	echo "1. Checking $app"
	
	# Get the Subversion URL for this project.
	URL=`svn info | grep URL`
	# Extract the name of the project
	NAME=`echo $URL | cut -d/ -f5`
	# Determine what the working copy refers to (trunk|branches)
	CURRENT=`echo $URL | cut -d/ -f6`
	# Derive the repository directories used by this project.
	ROOT="$REPO/$NAME"
	TRUNK="$ROOT/trunk"
	#TAGS="$ROOT/tags"
	#BRANCHES="$ROOT/branches"
	DEST="$ROOT/$OPT"
	# The new branch to be created (if any)
	NEW="$DEST/masc-$VERSION"
	COMMENT="Created branch for $VERSION"
	
	# See if the project has a branches directory. If not create one.
	svn ls $DEST > /dev/null
	if [ $? -ne 0 ] ; then
		# ls failed, branch "non-existent in that revision"
		svn mkdir $DEST -m "Created $OPT directory for $NAME" > /dev/null
	fi
	
	# See if we need to create a new branch
	svn ls $NEW > /dev/null
	if [ $? -ne 0 ] ; then
		echo "  2. Branching $app"
		if [ "$CURRENT" = "trunk" ] ; then
			echo "    3a. Branching the working copy."
			svn up
			svn copy . $NEW -m "$COMMENT"
		else
			echo "    3b. Branching from trunk"
			svn copy $TRUNK $NEW  -m "$COMMENT"
		fi 
		echo "  4. Switching $app to $NEW"
		svn switch $NEW	
	else
		echo "  2. Skipping $app, branch exists."
	fi	
	echo
}

if [ "$1" = "" ] ; then
	usage
	exit 1
fi


OPT="branches"
case $1 in
	tag)
		OPT="tags"
		;;
	branch)
		OPT="branches"
		;;
	*)
		usage
		exit 1
		;;
esac
set -u

cd $APPS
for dir in `ls -d */` ; do
	cd $dir
	if [ -d .svn ] ; then
		branch $dir
	fi	
	cd ..
done