#!/bin/bash

source ./config.sh
set -e

function usage
{
	echo "USAGE: $0 [-up] project-name"
	exit 1
}

if [ "$1" = "" ] ; then
	usage
fi

case $1 in
	-up)
		if [ "$2" = "" ] ; then
			usage
		fi
		UP="true"
		TARGET=$APPS/$2
		;;
	*)
		UP="false"
		TARGET=$APPS/$1
		;;
esac


# Build a single project used when processing MASC

if [ ! -e $TARGET ] ; then
	echo "Project $TARGET not found."
	exit 2
fi

cd $TARGET
if [ "$UP" = "true" ] ; then
	svn up
fi
mvn clean package
