#!/bin/bash
set -e

source ./config.sh
LOADER=$APPS/load-all/target/load-all.jar

set -u

# Loads all GrAF files with the GrafLoader.
java $OPTS -jar $LOADER $LOPTS -in=$DATA/release
