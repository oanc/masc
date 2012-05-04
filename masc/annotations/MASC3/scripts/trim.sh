#!/bin/bash

set -e

source ./config.sh

echo trim.sh

pwd
echo $TRIM
java $OPTS -jar $TRIM $LOPTS -in=$OUT -out=$OUT
