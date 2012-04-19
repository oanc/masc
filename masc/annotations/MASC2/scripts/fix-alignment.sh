#!/bin/bash

source ./config.sh

echo running fix-alignment.sh
grate scripts/fix_alignment.gr8 $OUT
