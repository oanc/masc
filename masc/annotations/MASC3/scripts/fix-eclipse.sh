#!/bin/bash
set -e

source ./config.sh

set -u
for dir in `ls $APPS` ; do
	if [ ! -e $APPS/$dir/.project ] ; then
		echo "Generating Eclipse project files for $dir"
		pushd $APPS/$dir > /dev/null
		mvn eclipse:eclipse
		popd > /dev/null
	fi
done