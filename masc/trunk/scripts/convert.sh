#!/bin/bash

echo "Running $0"

source ./config.sh

set -eu

JAR=$APPS/graf-update/target/graf-update.jar

DEST=$WORK/graf-1.0.0
if [ -e $DEST ] ; then
	rm -rf $DEST
fi
mkdir -p $DEST

#groovy -Xmx1G ./scripts/convert.groovy $MASC $DEST
java $OPTS -jar $JAR $LOPTS -in=$MASC -out=$DEST -c -prefix=MASC1

echo "Renaming header files."
cd $DEST
for header in `ls -1 *.anc` ; do
	new_name=`echo $header | sed 's/\.anc/.hdr/'`
	mv $header $new_name
done
echo "$0 complete."
