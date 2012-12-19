#!/bin/bash
set -eu

echo "Running $0"
source ./config.sh

grate addCesDoc.gr8 $RELEASE/resource-header.xml $RELEASE/data $RELEASE/data
