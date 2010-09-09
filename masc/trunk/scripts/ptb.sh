#!/bin/bash

source ./config.sh

#cd ..
# Convert and align the Penn Tree bank
java $OPTS -jar $CONVERT -ptb $LOPTS -set=PTB -id=ptb -in=$IN/ptb -out=$WORK/ptb 
#LOPTS=-log=./ptb.log\ -level=debug
java $OPTS -jar $ALIGN -type=ptb $LOPTS -src=$WORK/ptb -target=$OUT -dest=$OUT -fix=$FIX/ptb-fixes.xml #-skip -echo-target



