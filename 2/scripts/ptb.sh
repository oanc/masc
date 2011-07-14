#!/bin/bash

source ./config.sh

echo running ptb.sh

#cd ..
# Convert and align the Penn Tree bank
echo java $OPTS -jar $CONVERT -ptb $LOPTS -set=PTB -id=ptb -in=$IN/ptb -out=$WORK/ptb 
java $OPTS -jar $CONVERT -ptb $LOPTS -set=PTB -id=ptb -in=$IN/ptb -out=$WORK/ptb 

echo java $OPTS -jar $ALIGN -type=ptb $LOPTS -src=$WORK/ptb -target=$OUT -dest=$OUT -fix=$FIX/ptb-fixes.xml 
java $OPTS -jar $ALIGN -type=ptb $LOPTS -src=$WORK/ptb -target=$OUT -dest=$OUT -fix=$FIX/ptb-fixes.xml 

# Debugging version
#LOPTS=-log=./ptb.log\ -level=info
#java $OPTS -jar $ALIGN -type=ptb $LOPTS -src=$WORK/ptb -target=$OUT -dest=$OUT -fix=$FIX/ptb-fixes.xml -skip #-echo-target




