#!/bin/bash

echo "Running $0"
source ./config.sh

grate scripts/addCesDoc.gr8 $RELEASE/resource-header.xml $RELEASE/data $RELEASE/data
