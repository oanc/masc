#!/bin/bash

# NOTE: The check-tokens program is typically run from the reports.sh script.

source ./config.sh

set -eu

TOKENS=$APPS/check-tokens/target/check-tokens.jar
REPORT=./reports/check-tokens
if [ ! -e $REPORT ] ; then
	mkdir -p $REPORT
fi

#java $OPTS -jar $CHECK_TOKENS $LOPTS -in=$RELEASE/data -header=$RELEASE/resource-header.xml -out=$REPORT
java -Xmx2G -jar $TOKENS $LOPTS -in=$RELEASE/data -out=./reports -header=$METADATA/MASC3-resource-header.xml
