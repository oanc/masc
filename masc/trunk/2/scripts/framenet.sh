#!/bin/bash

source ./config.sh
#cd ..

echo running framenet.sh

# Convert and align FrameNet
echo java $OPTS -jar $CONVERT -fn $LOPTS -set=FrameNet -in=$IN/FrameNet -out=$WORK/framenet
java $OPTS -jar $CONVERT -fn $LOPTS -set=FrameNet -in=$IN/FrameNet -out=$WORK/framenet

echo java $OPTS -jar $ALIGN $LOPTS -type=fn -src=$WORK/framenet -target=$OUT -dest=$OUT -fix=$FIX/fn-fixes.xml
java $OPTS -jar $ALIGN $LOPTS -type=fn -src=$WORK/framenet -target=$OUT -dest=$OUT -fix=$FIX/fn-fixes.xml


