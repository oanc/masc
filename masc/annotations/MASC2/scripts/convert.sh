#!/bin/bash

# Converts the GrAF standoff annotation files to the latest version
source ./config.sh

echo Converting standoff files to latest GrAF version.
groovy scripts/convert.groovy $OUT $RELEASE

