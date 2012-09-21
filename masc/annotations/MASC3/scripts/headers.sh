#!/bin/bash

source ./config.sh

echo Generating headers.
if [ -d $DATA/headers ] ; then
	rm -f $DATA/headers/*.*
else
	mkdir -p $DATA/headers
fi

if [ -z "$CORPORA" ] ; then
	echo "\$CORPORA has not been set. Check your .bashrc and ensure ~/.masc.conf"
	echo "is being sourced."
	echo
	exit 2
fi

JAR=$APPS/masc-headers/target/masc-headers.jar
#java $OPTS -jar $JAR $CORPORA 3 $DROPBOX/MASC2-3/MASC-MASTER.csv $DATA/headers
java $OPTS -jar $JAR $CORPORA $DATA/headers $METADATA/MASC-MASTER.csv 3

# Fix and rename the ch3.hdr file.
sed 's/loc="ch3.txt"/loc="rybczynski-ch3.txt"/' $DATA/headers/rybczynski-ch3.hdr > /tmp/rybczynski-ch3.hdr
mv /tmp/rybczynski-ch3.hdr $DATA/headers/
#rm $DATA/headers/ch3.hdr

# The above generates all MASC headers. Copy only the MASC 3
# headers into the output directory
groovy scripts/copyheaders.groovy $DATA/headers $OUT

echo "Finished headers.sh"
