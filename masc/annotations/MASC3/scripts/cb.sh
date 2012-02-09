#!/bin/bash

source ./config.sh

echo running cb.sh

echo Work is $WORK

# Convert the Committed Belief data.  One file (in CB-new) also needs to be aligned.
CBWORK=$WORK/committed-belief
if [ -e $CBWORK ] ; then
	rm -f $CBWORK/*.*
else
	mkdir -p $CBWORK
fi

echo java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=CB -in=$IN/committed-belief -out=$OUT -saveAs=cb -id=cb
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=CB -in=$IN/committed-belief -out=$OUT -saveAs=cb -id=cb

echo java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=CB -in=$IN/CB-new -out=$CBWORK -saveAs=cb -id=cb
java $OPTS -jar $CONVERT -xces $LOPTS -set=xces -ann=CB -in=$IN/CB-new -out=$CBWORK -saveAs=cb -id=cb
cp $IN/CB-new/*.txt $CBWORK
java $OPTS -jar $ALIGN $LOPTS -src=$CBWORK -target=$OUT -dest=$OUT -type=cb
