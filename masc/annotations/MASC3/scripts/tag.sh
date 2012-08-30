#!/bin/bash

# Tags all the programs in the apps directory.

set -e
source ./config.sh

function usage {
	echo "USAGE: $0 [tag|branch] branch-name"
	exit
}

function tag {
	LOCAL=$1
	REMOTE=`svn info | grep URL | cut -d/ -f5`
	cd $LOCAL
	svn copy . $REPO/$REMOTE/$MODE/$TAGNAME
	if [ "$MODE" = "branches" ] ; then
		svn switch $REPO/$REMOTE/$MODE/$TAGNAME .
	fi
	cd ..
}

if [ "$1" = "" ] ; then
	usage
fi

# Check the command line parameters
case $2 in
	tag)
		MODE="tags"
		;;
	branch)
		MODE="branches"
		;;
	*)
		echo "Invalid mode."
		usage
		;;
esac

echo "Shouldn't reach here."
exit

TAGNAME=$2

set -u
REPO=https://www.anc.org/dev

cd $APPS
for app in `ls -d */` ; do
	tag $app 
done

#tag "align" "GrafAlign"
#tag "convert" "GrafConvert"
#tag "check-ids" "check-ids"
#tag "graph-splitter" "graph-splitter"
#tag "copy-files" "copy-files"
#tag "validate-headers" "validate-headers"
#build "fix-corrections" "fix-corrections"
#tag "check-ids" "check-ids"
#tag "link-tokens" "link-tokens"
#tag "validator" "validator"
#build "make-tree" "make-tree"
#tag "divide-corpus" "divide-corpus"
#tag "parse-all" "parse-all"
#tag "trim" "trim"
#tag "check-align" "check-align"
#tag "update-headers" "update-headers"
#build "masc-headers" "masc-headers"
#tag "check-nodes" "check-nodes"
#tag "check-docid" "check-docid"
#tag "check-headers" "check-headers"
#tag "check-tokens" "check-tokens"
#tag "load-all" "load-all"


echo "Tagging complete."