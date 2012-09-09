#!/bin/bash

source ./config.sh

set -eu

CHECK_TOKENS=$APPS/check-tokens/target/check-tokens.jar
REPORT=./reports/check-tokens
if [ ! -e $REPORT ] ; then
	mkdir -p $REPORT
fi

java $OPTS -jar $CHECK_TOKENS $LOPTS -in=$RELEASE/data -header=$RELEASE/resource-header.xml -out=$REPORT
