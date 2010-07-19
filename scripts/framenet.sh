#!/bin/bash

source ./config.sh
#cd ..

# Convert and align FrameNet
java $OPTS -jar $CONVERT -fn $LOPTS -set=FrameNet -in=$IN/FrameNet -out=$WORK/framenet
java $OPTS -jar $ALIGN $LOPTS -type=fn -src=$WORK/framenet -target=$OUT -dest=$OUT -fix=$FIX/fn-fixes.xml


