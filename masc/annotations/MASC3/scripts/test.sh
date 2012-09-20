#!/bin/bash

echo "Enter the MASC project root directory:"
read MASC_ROOT

echo "Enter the destination directory:"
read CORPORA

echo "MASC root is $MASC_ROOT"
echo "CORPORA is $CORPORA"

ls $CORPORA
